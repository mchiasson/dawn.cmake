# Copyright (c) 2019 Mathieu-André Chiasson
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if(APPLE)
    find_path(METAL_INCLUDE_DIR Metal/Metal.h)
    find_library(METAL_FRAMEWORKS Metal)

    if(METAL_FRAMEWORKS)
        set(METAL_LIBRARIES "-framework Metal -framework QuartzCore -framework Cocoa.framework -framework IOKit.framework -framework IOSurface.framework")
    endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(METAL  DEFAULT_MSG
                                  METAL_INCLUDE_DIR METAL_LIBRARIES)

mark_as_advanced(METAL_INCLUDE_DIR METAL_LIBRARIES)
