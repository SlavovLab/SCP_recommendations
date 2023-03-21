# **Initial recommendations for performing, benchmarking, and reporting single-cell proteomics experiments**

<!--![GitHub release](https://img.shields.io/github/release/SlavovLab/DO-MS.svg)-->

![GitHub](https://img.shields.io/github/license/SlavovLab/DO-MS.svg)

- [Guidelines Website](https://single-cell.net/guidelines)
- [Preprint](https://arxiv.org/abs/2207.10815)

&nbsp;

<img src="https://single-cell.net/proteomics/photos/Data-evaluation-and-interpretation.png" width="70%">

---

The white paper with community guidelines and recommendations is freely available on arXiv: [Gatto et al., 2022](https://doi.org/10.48550/arXiv.2207.10815). <!-- The peer reviewed version is available at *Nature Biotechnology*: [Derks et al., 2022](https://doi.org/10.1038/s41587-022-01389-w) -->

For more information, contact [Slavov Laboratory](https://slavovlab.net).

## Running the code in this repository

_Prerequisites_: This recipe assumes a compute system with docker installed and access to the internet.

The code in the SCP recommendations repository can be run with the following sequence of commands:

```
git clone https://github.com/SlavovLab/SCP_recommendations.git
docker run \
  --rm -it \
  --volume $(pwd)/code:/code \
  --volume $(pwd)/figs:/figs \
  fabianegli/scp-recommendations-2022:1.0 \
  Rscript "./code/make_figure2e.R"
```

This will re-create the figures into the `figs` folder mounted to the docker container with the `--volumes` parameter in the command above.

The [Dockerfile](./Dockerfile) and together with [install_dependencies.R](./install_dependencies.R) were used to produce the Docker image `fabianegli/scp-recommendations-2022:1.0`.

## License

The code is distributed by an [MIT license](https://github.com/SlavovLab/DO-MS/blob/master/LICENSE).

## Contributing

Please feel free to contribute to this project by opening an issue or pull request.

<!--
### Data
All data used for the manuscript is available on [UCSD's MassIVE Repository](https://massive.ucsd.edu/ProteoSAFe/dataset.jsp?task=ed5a1ab37dc34985bbedbf3d9a945535)
-->

<!--
### Figures/Analysis
Scripts for the figures in the DART-ID manuscript are available in a separate GitHub repository, [https://github.com/SlavovLab/DART-ID_2018](https://github.com/SlavovLab/DART-ID_2018)
-->

---

## Help!

For any bugs, questions, or feature requests,
please use the [GitHub issue system](https://github.com/SlavovLab/SCP_recommendations/issues) to contact the developers.
