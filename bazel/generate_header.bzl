#===============================================================================
# Copyright 2021 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================

def _generate_header_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.template,
        substitutions = ctx.attr.substitutions,
    )
    return [CcInfo(
        compilation_context = cc_common.create_compilation_context(
            includes = depset([out.dirname]),
            headers = depset([out]),
        ),
    )]

generate_header = rule(
    implementation = _generate_header_impl,
    attrs = {
        "substitutions": attr.string_dict(
            mandatory = True,
        ),
        "template": attr.label(
            allow_single_file = [".h.in"],
            mandatory = True,
        ),
    },
)
