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
 * \file cookTorrance.vsh
 * \brief Vertex shader for the Cook Torrance BRDF.
 * \author Antoine Toisoul Le Cann
 * \date September, 1st, 2016
 *
 * Vertex shader for the Cook Torrance BRDF. Also implements environment mapping.
 */

#version 400

uniform mat4 mvMatrix;
uniform mat4 pMatrix;
uniform mat3 normalMatrix; //mv matrix without translation

uniform vec4 lightPosition_camSpace; //light Position in camera space

in vec4 vertex_worldSpace;
in vec3 normal_worldSpace;
in vec2 textureCoordinate_input;

out vec4 varyingVertex_camSpace;
out vec4 varyingLightPosition_camSpace;

out vec3 varyingNormal_camSpace;
out vec2 varyingTextureCoordinate;

//Vertex shader
void main(void)
{
    //Put the vertex in the correct coordinate system by applying the model view matrix
    vec4 vertex_camSpace = mvMatrix*vertex_worldSpace;
	
	//The interpolated vertex position will be used in the fragment shader to get a better approximation of the viewing and lighting directions and 
	//omega_i and omega_o are computed in the fragment shader
	varyingVertex_camSpace = vertex_camSpace; 
	varyingLightPosition_camSpace = lightPosition_camSpace;
	
	//Apply the model transformation to the normal (only rotation, no translation)
    varyingNormal_camSpace = normalize(normalMatrix*normal_worldSpace);
	
	varyingTextureCoordinate = textureCoordinate_input;
	
    gl_Position = pMatrix * vertex_camSpace;
}

