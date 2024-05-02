# Process Mining using R
## NHS England East of England - Intelligence & Insight

### About the Project

[![status: experimental](https://github.com/GIScience/badges/raw/master/status/experimental.svg)](https://github.com/GIScience/badges#experimental)

This repository holds code for the Process Mining using R and contains everything you need to get you started.

_**Note:** Only public or fake data are shared in this repository._

### Project Stucture

- The main code is found in the root of the repository (see Usage below for more information)
- The accompanying [report](./reports/report.pdf) is also available in the `reports` folder
- More information about the code usage can be found in the [model card](./model_card.md)
- {OTHER REPO STRUCTURE}

### Built With

R Studio
- (https://bupaverse.github.io/docs/index.html)

### Getting Started

#### Installation

To get a local copy up and running follow these simple steps:

1. Clone repo
2. Set up project in R linked to your cloned Git repository
3. Change file path in R script to local file path (using artificial data within this repo)

To clone the repo:

`git clone https://github.com/RubyNixx/Process_Mining_R_Healthcare`

To create a suitable environment:
- R Studio
- Libraries are contained with the R script


### Usage
The R code provides examples, using 1 dataset, of the different types of visualisations for process mining you can create using the bupaverse package.

#### Outputs
Charts are outputted to screen when you run the code.

#### Datasets

Fake data is used within project, which has been manually transformed to meet NHS Data Dictionary fields. (Bssed on this dataset: https://gitlab.com/healthcare2/process-mining-tutorial/-/blob/master/ArtificialPatientTreatment.csv?ref_type=heads)

The script loads this from the test data excel file and then generates a event log, so the only change you should need to make to get this to run on your own instance is to re-direct the readexcel file path to your own.

There are 100 test pathways, of which some look like rework, to make it easier as a beginner select a smaller set of pathways to understand the range of visualisation.

### Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

_See [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed guidance._

### License

Unless stated otherwise, the codebase is released under [the MIT Licence][mit].
This covers both the codebase and any sample code in the documentation.

_See [LICENSE](./LICENSE) for more information._

The documentation is [© Crown copyright][copyright] and available under the terms
of the [Open Government 3.0][ogl] licence.

[mit]: LICENCE
[copyright]: http://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/
[ogl]: http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/

### Contact
ruby.nicholls@nhs.net

Technical contact: ruby.nicholls@nhs.net

<!-- ### Acknowledgements -->

Thanks to Mike Perham for all your support and guidance.
