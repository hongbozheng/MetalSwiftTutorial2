//
//  Shader.metal
//  testMetalSwift
//
//  Created by Danny on 5/21/17.
//  Copyright © 2017 Danny. All rights reserved.
//


#include <metal_stdlib>
using namespace metal;

struct Uniforms{
    float4x4 modelMatrix;
    float4x4 projectionMatrix;
};

struct VertexIn{
    packed_float3 position;
    packed_float4 color;
};

struct VertexOut{
    float4 position [[position]];
    float4 color;
};

vertex VertexOut basic_vertex(
    const device VertexIn * vertex_array [[buffer(0)]],
    const device Uniforms& Uniforms [[buffer(1)]],
    unsigned int vid [[vertex_id]]) {
    
    float4x4 mv_Matrix = Uniforms.modelMatrix;
    float4x4 proj_Matrix = Uniforms.projectionMatrix;
    
    VertexIn VertexIn = vertex_array[vid];
    VertexOut VertexOut;
    VertexOut.position = proj_Matrix * mv_Matrix * float4(VertexIn.position,1);
    VertexOut.color = VertexIn.color;
    
    return VertexOut;
}


fragment half4 basic_fragment(VertexOut interpolated [[stage_in]]) {
    return half4(interpolated.color[0],interpolated.color[1],interpolated.color[2],interpolated.color[3]);
}
