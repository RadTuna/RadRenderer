#include <iostream>
#include <glm/vec2.hpp>
#include <glm/geometric.hpp>

int main()
{
    glm::vec2 v1(1, 2);
    glm::vec2 v2(2, 4);

    const float test = glm::dot(v1, v2);

    std::cout << "TEST PROGRAM! : " << test << std::endl;
    return 0;
}
