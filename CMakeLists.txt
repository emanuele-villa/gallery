cmake_minimum_required(VERSION 3.6)

project(gallerydemo)

set(CMAKE_CXX_STANDARD 17)

include_directories($ENV{BOOST_INC})
include_directories($ENV{CANVAS_INC})
include_directories($ENV{CANVAS_ROOT_IO_INC})
include_directories($ENV{CETLIB_EXCEPT_INC})
include_directories($ENV{CETLIB_INC})
include_directories($ENV{FHICLCPP_INC})
include_directories($ENV{GALLERY_INC})
include_directories($ENV{LARCOREOBJ_INC})
include_directories($ENV{LARCOREALG_INC})
include_directories($ENV{LARDATAOBJ_INC})
include_directories($ENV{NUSIMDATA_INC})
include_directories($ENV{ROOT_INC})
link_directories($ENV{ROOTSYS}/lib $ENV{CANVAS_LIB} $ENV{CETLIB_EXCEPT_LIB} $ENV{CETLIB_LIB} $ENV{GALLERY_LIB} $ENV{NUSIMDATA_LIB} $ENV{LARCOREOBJ_LIB} $ENV{LARDATAOBJ_LIB})

add_executable(demo demo.cc analyze.cc)
#add_executable(myconverter myconverter.cc analyze.cc)

# To set the C++ standard to be used, only one of the following two lines should
# be un-commented.
# set_property(TARGET demo PROPERTY CXX_STANDARD 14)
# set_property(TARGET demo PROPERTY CXX_STANDARD 17)

target_link_libraries(demo Core RIO Net Hist Graf Graf3d Gpad Tree Rint Postscript Matrix Physics MathCore Thread MultiProc pthread canvas cetlib_except cetlib gallery nusimdata_SimulationBase larcoreobj_SummaryData lardataobj_RecoBase)
