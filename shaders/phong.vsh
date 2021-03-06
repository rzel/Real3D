#version 400
/*
 *     Real3D
 *
 *     Author:  Antoine TOISOUL LE CANN
 *
 *     Copyright © 2016 Antoine TOISOUL LE CANN
 *              All rights reserved
 *
 *
 * Real3D is free software: you can redistribute it and/or modify
 *
 * it under the terms of the GNU Lesser General Public License as published by
 *
 * the Free Software Foundation, either version 3 of the License, or
 *
 * (at your option) any later version.
 *
 * Real3D is distributed in the hope that it will be useful,
 *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 *
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * \file phong.vsh
 * \brief Vertex shader for the Phong BRDF.
 * \author Antoine Toisoul Le Cann
 * \date September, 1st, 2016
 *
 * Vertex shader for the Phong BRDF.
 */

uniform mat4 mvMatrix;
uniform mat4 pMatrix;
uniform mat3 normalMatrix; //mv matrix without translation

uniform vec4 lightPosition_camSpace; //light Position in camera space

in vec4 vertex_worldSpace;
in vec3 normal_worldSpace;
in vec2 textureCoordinate_input;

out vec3 varyingNormal_camSpace;
out vec3 varyingLightDirection_camSpace;
out vec3 varyingViewingDirection_camSpace;
out vec2 varyingTextureCoordinates;

//Vertex shader compute the vectors per vertex
void main(void)
{
    //Put the vertex in the correct coordinate system by applying the model view matrix
    vec4 vertex_camSpace = mvMatrix*vertex_worldSpace;
	
    //Apply the model-view transformation to the normal (only rotation, no transloation)
    //Normals put in the view space
    varyingNormal_camSpace = normalMatrix*normal_worldSpace;

    //Direction of the light source : omega_i vector
    //Light direction and eyeVertex are in the camera space
    varyingLightDirection_camSpace = lightPosition_camSpace.xyz-vertex_camSpace.xyz;

    //Direction of the camera : omega_o vector
    //omega_o = positionCamera-vertex but positionCamera is (0,0,0) in the coordinate system of the camera
    varyingViewingDirection_camSpace = -vertex_camSpace.xyz;
	
	varyingTextureCoordinates = textureCoordinate_input;
	
    gl_Position = pMatrix * vertex_camSpace;
}
