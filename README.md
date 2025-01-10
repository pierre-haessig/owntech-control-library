# OwnTech Control library in Modelica

This repository contains a Modelica package, `OwnControl`, to model [OwnTech](https://owntech.io/) C++ [Control library](https://docs.owntech.org/latest/controlLibrary/docs/getting-started/) using block diagrams in Modelica. OwnTech Control library contains signal processing and control classes and functions dedicated for power electronics.

## Usage

Requirements: you need a Modelica simulation environment. 
- `OwnModel` has been developed and tested with [OpenModelica](https://openmodelica.org/) 1.24

1. clone or download (and unzip) this repository
2. open the `OwnControl` package (can be done by double-clicking the `OwnControl/package.mo` file from your file browser)
3. Within your Modelica environment, navigate through the package. You can start with the `Examples/TransformsDemo` model which implements a three-phase signal being transformed to its Clarke αβ and Park dq components


## Package structure

The `OwnControl` package is structured like many Modelica libraries with the following subpackages:

- **Examples**: demos of filters and control loops that can be directly simulated
- **Components**: models of subsystems (i.e. that cannot be simulated alone), including:
  - TWIST board
  - Power converter legs (switched or averaged model)
  - LC filter
- **Interfaces** (not needed by model users): [parent](https://mbe.modelica.university/behavior/equations/model_def/#inheritance) abstract/partial model classes that are used to factor out common aspects from sibling components

## About implementation

The `OwnControl` library reuses interfaces and is compatible with the [Blocks](https://build.openmodelica.org/Documentation/Modelica.Blocks.html) library of the Modelica Standard Library (MSL) version 4.0.0

## Development Status

Early stage:

- Transforms: OK and tested :white_check_mark:
- PLL: Structure of abstract SRF and SOGI-SFR PLL probably OK, but not tested
  - :warning: SOGI PLL demo fails
