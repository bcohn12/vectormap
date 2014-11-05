﻿#!/usr/bin/python

from platform_open import *
from ctypes import *
import polyhedra, blob

# Import OpenCTM python bindings
from sys import path as module_paths
module_paths.append('./pyctm')


###############################

filename = "sphere.ctm"
num_subdivisions = 3

verts, faces = polyhedra.icosahedron()
for x in xrange(num_subdivisions):
    verts, faces = polyhedra.subdivide(verts, faces)
pVerts = blob.make_blob(verts, c_float)
pFaces = blob.make_blob(faces, c_uint)
pNormals = POINTER(c_float)()

