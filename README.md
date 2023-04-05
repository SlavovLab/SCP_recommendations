# **Initial recommendations for performing, benchmarking, and reporting single-cell proteomics experiments**


![GitHub](https://img.shields.io/github/license/SlavovLab/DO-MS.svg)


* [Guidelines Website](https://single-cell.net/guidelines)
* [The *Nature Methods* white paper](https://www.nature.com/articles/s41592-023-01785-3)
* [Blog](https://blog.slavovlab.net/2023/03/04/guidelines-for-single-cell-proteomic-experiments/)

&nbsp;

<img src="https://single-cell.net/proteomics/photos/Data-evaluation-and-interpretation.png" width="70%">


&nbsp;

* [Example *README* file](https://www.nature.com/articles/s41592-023-01785-3#Sec29)
* [Example *Data websites*](https://scp.slavovlab.net/data)


&nbsp;

> We expect that broadly accepted community guidelines and standardized metrics will enhance rigor, data quality and alignment between laboratories.

[The *Nature Methods* white paper](https://www.nature.com/articles/s41592-023-01785-3) proposed best practices, quality controls and data-reporting recommendations to assist in the broad adoption of reliable quantitative workflows for single-cell proteomics.

---

The white paper with community guidelines and recommendations is freely available at *Nature Methods*: [*Performing, benchmarking, and reporting single-cell proteomics experiments*](https://www.nature.com/articles/s41592-023-01785-3), *Nature Methods*, **20**, 375--386 (2023) doi: [10.1038/s41592-023-01785-3](https://doi.org/10.1038/s41592-023-01785-3)


The preprint is available at the *arXiv*: [Gatto et al., 2022](https://doi.org/10.48550/arXiv.2207.10815).


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

The [Dockerfile](./Dockerfile) together with [install_dependencies.R](./install_dependencies.R) were used to produce the Docker image `fabianegli/scp-recommendations-2022:1.0` which is available on Docker Hub.

## License

The code is distributed by an [MIT license](https://github.com/SlavovLab/DO-MS/blob/master/LICENSE).

## Contributing

Please feel free to contribute to this project by opening an issue or pull request.

---

## Help!

For any bugs, questions, or feature requests,
please use the [GitHub issue system](https://github.com/SlavovLab/SCP_recommendations/issues) to contact the developers.
