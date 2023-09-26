
// Primary Include
#include "RenderPass.h"

// Internal Include
#include "Renderer/RenderDevice.h"
#include "Renderer/SwapChain.h"


RenderPass::RenderPass(RenderDevice* renderDevice, RenderSwapChain* swapChain)
    : RenderObject(renderDevice)
    , mSwapChain(swapChain)
    , mRenderPass(VK_NULL_HANDLE)
    , mFinalFormat(VK_FORMAT_UNDEFINED)
{
    mFinalFormat = mSwapChain->GetImageFormat();
    bool bResult = CreateRenderPass();
    if (bResult == false)
    {
        ASSERT_NEVER();
    }

    for (size_t index = 0; index < Renderer::MAX_FRAME_IN_FLIGHT; ++index)
    {
        bResult = CreateBuffer(index);
        if (bResult == false)
        {
            ASSERT_NEVER();
        }

        bResult = CreateSampler(index);
        if (bResult == false)
        {
            ASSERT_NEVER();
        }
    }
}

RenderPass::~RenderPass()
{
}

bool RenderPass::CreateRenderPass()
{
    VkAttachmentDescription colorAttachment = {};
    colorAttachment.format = mFinalFormat;
    colorAttachment.samples = VK_SAMPLE_COUNT_1_BIT;
    colorAttachment.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
    colorAttachment.storeOp = VK_ATTACHMENT_STORE_OP_STORE;
    colorAttachment.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
    colorAttachment.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
    colorAttachment.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
    colorAttachment.finalLayout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL;

    VkAttachmentReference colorAttachmentRef = {};
    colorAttachmentRef.attachment = 0;
    colorAttachmentRef.layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;

    VkSubpassDescription subPass = {};
    subPass.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS;
    subPass.colorAttachmentCount = 1;
    subPass.pColorAttachments = &colorAttachmentRef;

    VkSubpassDependency dependency = {};
    dependency.srcSubpass = VK_SUBPASS_EXTERNAL;
    dependency.dstSubpass = VK_SUBPASS_CONTENTS_INLINE;
    dependency.srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
    dependency.srcAccessMask = VK_ACCESS_NONE_KHR;
    dependency.dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
    dependency.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;

    VkRenderPassCreateInfo renderPassCreateInfo = {};
    renderPassCreateInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
    renderPassCreateInfo.attachmentCount = 1;
    renderPassCreateInfo.pAttachments = &colorAttachment;
    renderPassCreateInfo.subpassCount = 1;
    renderPassCreateInfo.pSubpasses = &subPass;
    renderPassCreateInfo.dependencyCount = 1;
    renderPassCreateInfo.pDependencies = &dependency;

    VkResult result = vkCreateRenderPass(*mRenderDevice, &renderPassCreateInfo, nullptr, &mRenderPass);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create main render pass.");
        return false;
    }

    return true;
}

bool RenderPass::CreateBuffer(size_t index)
{
    // goto handling brace
    {
        bool bResult = true;

        const VkExtent2D& swapChainExtent = mSwapChain->GetExtent();

        VkImageCreateInfo imageCreateInfo = {};
        imageCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
        imageCreateInfo.imageType = VK_IMAGE_TYPE_2D;
        imageCreateInfo.format = mFinalFormat;
        imageCreateInfo.extent.width = swapChainExtent.width;
        imageCreateInfo.extent.height = swapChainExtent.height;
        imageCreateInfo.extent.depth = 1;
        imageCreateInfo.mipLevels = 1;
        imageCreateInfo.arrayLayers = 1;
        imageCreateInfo.samples = VK_SAMPLE_COUNT_1_BIT;
        imageCreateInfo.tiling = VK_IMAGE_TILING_OPTIMAL;
        imageCreateInfo.usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;
        imageCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
        imageCreateInfo.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;

        VkResult result = vkCreateImage(*mRenderDevice, &imageCreateInfo, nullptr, &mFinalBuffers[index].Image);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Warning, "Failed to create a render pass buffer image.");
            return false;
        }

        VkMemoryRequirements memRequirements;
        vkGetImageMemoryRequirements(*mRenderDevice, mFinalBuffers[index].Image, &memRequirements);

        VkMemoryAllocateInfo allocInfo = {};
        allocInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
        allocInfo.allocationSize = memRequirements.size;
        allocInfo.memoryTypeIndex = mRenderDevice->FindPhysicalMemoryType(memRequirements.memoryTypeBits, VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);

        result = vkAllocateMemory(*mRenderDevice, &allocInfo, nullptr, &mFinalBuffers[index].Memory);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Warning, "Failed to allocate memory for a render pass buffer image.");
            goto DESTROY_IMAGE;
        }

        VK_ASSERT(vkBindImageMemory(*mRenderDevice, mFinalBuffers[index].Image, mFinalBuffers[index].Memory, 0));


        VkImageViewCreateInfo imageViewCreateInfo = {};
        imageViewCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        imageViewCreateInfo.image = mFinalBuffers[index].Image;
        imageViewCreateInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
        imageViewCreateInfo.format = mFinalFormat;
        imageViewCreateInfo.components.r = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.g = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.b = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.a = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
        imageViewCreateInfo.subresourceRange.baseMipLevel = 0;
        imageViewCreateInfo.subresourceRange.levelCount = 1;
        imageViewCreateInfo.subresourceRange.baseArrayLayer = 0;
        imageViewCreateInfo.subresourceRange.layerCount = 1;

        result = vkCreateImageView(*mRenderDevice, &imageViewCreateInfo, nullptr, &mFinalBuffers[index].ImageView);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Warning, "Failed to create a render pass buffer image view");
            goto DESTROY_MEMORY;

        }


        const VkImageView attachments[] = {
            mFinalBuffers[index].ImageView
        };

        VkFramebufferCreateInfo frameBufferCreateInfo = {};
        frameBufferCreateInfo.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
        frameBufferCreateInfo.renderPass = mRenderPass;
        frameBufferCreateInfo.attachmentCount = static_cast<uint32_t>(ArraySize(attachments));
        frameBufferCreateInfo.pAttachments = attachments;
        frameBufferCreateInfo.width = swapChainExtent.width;
        frameBufferCreateInfo.height = swapChainExtent.height;
        frameBufferCreateInfo.layers = 1;

        result = vkCreateFramebuffer(*mRenderDevice, &frameBufferCreateInfo, nullptr, &mFinalBuffers[index].FrameBuffer);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Error, "Failed to create render pass frame buffer.");
            goto DESTROY_IMAGE_VIEW;
        }

        VkSamplerCreateInfo samplerCreateInfo = {};

        return true;
    }

    // Error handling
DESTROY_IMAGE_VIEW:
    vkDestroyImageView(*mRenderDevice, mFinalBuffers[index].ImageView, nullptr);
DESTROY_MEMORY:
    vkFreeMemory(*mRenderDevice, mFinalBuffers[index].Memory, nullptr);
DESTROY_IMAGE:
    vkDestroyImage(*mRenderDevice, mFinalBuffers[index].Image, nullptr);

    return false;
}

bool RenderPass::CreateSampler(size_t index)
{
    VkSamplerCreateInfo samplerInfo = { };
    samplerInfo.sType = VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;
    samplerInfo.magFilter = VK_FILTER_LINEAR;
    samplerInfo.minFilter = VK_FILTER_LINEAR;
    samplerInfo.addressModeU = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER;
    samplerInfo.addressModeV = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER;
    samplerInfo.addressModeW = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER;
    samplerInfo.anisotropyEnable = VK_FALSE;
    samplerInfo.maxAnisotropy = 0.0f;
    samplerInfo.borderColor = VK_BORDER_COLOR_INT_OPAQUE_BLACK;
    samplerInfo.unnormalizedCoordinates = VK_FALSE;
    samplerInfo.compareEnable = VK_FALSE;
    samplerInfo.compareOp = VK_COMPARE_OP_ALWAYS;
    samplerInfo.mipmapMode = VK_SAMPLER_MIPMAP_MODE_LINEAR;
    samplerInfo.mipLodBias = 0.0f;
    samplerInfo.minLod = 0.0f;
    samplerInfo.maxLod = 0.0f;

    VkResult result = vkCreateSampler(*mRenderDevice, &samplerInfo, nullptr, &mFinalBuffers[index].Sampler);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Warning, "Failed to crate render pass sampler.");
        return false;
    }

    return true;
}
