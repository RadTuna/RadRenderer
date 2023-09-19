
// Primary Include
#include "SwapChain.h"

// External Include
#include <GLFW/glfw3.h>
#include <algorithm>

// Internal Include
#include "Core/Application.h"
#include "Renderer/RenderDevice.h"


RenderSwapChain::RenderSwapChain()
    : mRenderDevice(nullptr)
    , mSwapChain(VK_NULL_HANDLE)
    , mExtent{ 0, }
    , mImageFormat(VK_FORMAT_UNDEFINED)
{
}

RenderSwapChain::~RenderSwapChain()
{
    Destroy();
}

bool RenderSwapChain::Create(RenderDevice* device)
{
    assert(device != nullptr);
    mRenderDevice = device;

    const SwapChainSupportDetails details = device->QuerySwapCahinSupport();
    const VkSurfaceFormatKHR surfaceFormat = ChooseSwapSurfaceFormat(details.Formats);
    const VkPresentModeKHR presentMode = ChooseSwapPresentMode(details.PresentModes);
    const VkExtent2D extent = ChooseSwapExtent(details.Capabilities);

    uint32_t imageCount = details.Capabilities.minImageCount + 1;
    if (details.Capabilities.maxImageCount > 0 && details.Capabilities.maxImageCount < imageCount)
    {
        imageCount = details.Capabilities.maxImageCount;
    }

    VkSwapchainCreateInfoKHR swapChainCreateInfo = {};
    swapChainCreateInfo.sType = VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
    swapChainCreateInfo.surface = device->GetSurface();
    swapChainCreateInfo.minImageCount = imageCount;
    swapChainCreateInfo.imageFormat = surfaceFormat.format;
    swapChainCreateInfo.imageColorSpace = surfaceFormat.colorSpace;
    swapChainCreateInfo.imageExtent = extent;
    swapChainCreateInfo.imageArrayLayers = 1;
    swapChainCreateInfo.imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;

    const QueueFamilyIndices indices = device->FindQueueFamilies();
    assert(QueueFamilyIndices::IsValidQueueFamilyIndices(indices) == true);
    std::vector<uint32_t> uniqueQueueFamilies = QueueFamilyIndices::GetUniqueFamilies(indices);

    // Graphics queue와 Transfer queue가 다르도록 강제하기에 CONCURRENT 모드 사용.
    // CONCURRENT 모드 사용 시에는 QueueFamilyIndex가 Unique 해야함.
    swapChainCreateInfo.imageSharingMode = VK_SHARING_MODE_CONCURRENT;
    swapChainCreateInfo.queueFamilyIndexCount = static_cast<uint32_t>(uniqueQueueFamilies.size());
    swapChainCreateInfo.pQueueFamilyIndices = uniqueQueueFamilies.data();

    swapChainCreateInfo.preTransform = details.Capabilities.currentTransform;
    swapChainCreateInfo.compositeAlpha = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
    swapChainCreateInfo.presentMode = presentMode;
    swapChainCreateInfo.clipped = VK_TRUE;
    swapChainCreateInfo.oldSwapchain = VK_NULL_HANDLE;

    VkResult result = vkCreateSwapchainKHR(*device, &swapChainCreateInfo, nullptr, &mSwapChain);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan swap chain.");
        return false;
    }

    mExtent = extent;
    mImageFormat = surfaceFormat.format;

    uint32_t swapImageCount = 0;
    VK_ASSERT(vkGetSwapchainImagesKHR(*device, mSwapChain, &swapImageCount, nullptr));
    mSwapChainImages.resize(swapImageCount);
    VK_ASSERT(vkGetSwapchainImagesKHR(*device, mSwapChain, &swapImageCount, mSwapChainImages.data()));

    // Begin create swap chain image views
    mSwapChainImageViews.resize(mSwapChainImages.size());
    for (size_t i = 0; i < mSwapChainImages.size(); ++i)
    {
        VkImageViewCreateInfo imageViewCreateInfo = {};
        imageViewCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        imageViewCreateInfo.image = mSwapChainImages[i];
        imageViewCreateInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
        imageViewCreateInfo.format = mImageFormat;
        imageViewCreateInfo.components.r = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.g = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.b = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.a = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
        imageViewCreateInfo.subresourceRange.baseMipLevel = 0;
        imageViewCreateInfo.subresourceRange.levelCount = 1;
        imageViewCreateInfo.subresourceRange.baseArrayLayer = 0;
        imageViewCreateInfo.subresourceRange.layerCount = 1;

        result = vkCreateImageView(*device, &imageViewCreateInfo, nullptr, &mSwapChainImageViews[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create swap chain image view.");
            return false;
        }
    }

    return true;
}

void RenderSwapChain::Destroy()
{
    for (VkFramebuffer frameBuffer : mFrameBuffers)
    {
        vkDestroyFramebuffer(*mRenderDevice, frameBuffer, nullptr);
    }
    mFrameBuffers.clear();

    for (VkImageView imageView : mSwapChainImageViews)
    {
        vkDestroyImageView(*mRenderDevice, imageView, nullptr);
    }
    mSwapChainImageViews.clear();

    if (mSwapChain != VK_NULL_HANDLE)
    {
        vkDestroySwapchainKHR(*mRenderDevice, mSwapChain, nullptr);
        mSwapChain = VK_NULL_HANDLE;
    }
}

bool RenderSwapChain::CreateFrameBuffers(VkRenderPass renderPass)
{
    mFrameBuffers.resize(mSwapChainImageViews.size());

    for (size_t i = 0; i < mSwapChainImageViews.size(); ++i)
    {
        VkImageView attachments[] = {
            mSwapChainImageViews[i]
        };

        VkFramebufferCreateInfo frameBufferCreateInfo = {};
        frameBufferCreateInfo.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
        frameBufferCreateInfo.renderPass = renderPass;
        frameBufferCreateInfo.attachmentCount = static_cast<uint32_t>(ArraySize(attachments));
        frameBufferCreateInfo.pAttachments = attachments;
        frameBufferCreateInfo.width = mExtent.width;
        frameBufferCreateInfo.height = mExtent.height;
        frameBufferCreateInfo.layers = 1;

        const VkResult result = vkCreateFramebuffer(*mRenderDevice, &frameBufferCreateInfo, nullptr, &mFrameBuffers[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create frame buffer.");
            return false;
        }
    }

    return true;
}

VkSurfaceFormatKHR RenderSwapChain::ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const
{
    for (const VkSurfaceFormatKHR avaliableFormat : avaliableFormats)
    {
        if (avaliableFormat.format == VK_FORMAT_B8G8R8A8_SRGB
            && avaliableFormat.colorSpace == VK_COLORSPACE_SRGB_NONLINEAR_KHR)
        {
            return avaliableFormat;
        }
    }

    return avaliableFormats.front();
}

VkPresentModeKHR RenderSwapChain::ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const
{
    for (const VkPresentModeKHR& avaliablePresentMode : avaliablePresentModes)
    {
        if (avaliablePresentMode == VK_PRESENT_MODE_MAILBOX_KHR)
        {
            return avaliablePresentMode;
        }
    }

    return VK_PRESENT_MODE_FIFO_KHR; // Guaranteed to be always avaliable.
}

VkExtent2D RenderSwapChain::ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilities) const
{
    VkExtent2D actualExtent = capabilities.currentExtent;
    if (capabilities.currentExtent.width == UINT32_MAX)
    {
        int width = 0;
        int height = 0;

        GLFWwindow* windowObject = Application::GetApplicationOrNull()->GetWindowObject();
        glfwGetFramebufferSize(windowObject, &width, &height);

        actualExtent.width = static_cast<uint32_t>(width);
        actualExtent.height = static_cast<uint32_t>(height);
        actualExtent.width = std::clamp(actualExtent.width, capabilities.minImageExtent.width, capabilities.maxImageExtent.width);
        actualExtent.height = std::clamp(actualExtent.height, capabilities.minImageExtent.height, capabilities.maxImageExtent.height);
    }

    return actualExtent;
}
