# Time Series Data Catalog and Transformation Specifications

## 1. Table of Contents
* 1.1 Source Datasets Overview
* 1.2 Target Price Series (my.xls)
* 1.3 Macroeconomic Predictors (mx.xls)
* 1.4 Dynamic Rotation Monitoring Series (mz.xls)
* 1.5 Preprocessing and Transformation Pipeline
* 1.6 Sample Splits and Evaluation Windows

---

## 1.1 Source Datasets Overview
* Four source workbooks in `data/`:
  * `my.xls`: West Texas Intermediate crude oil prices and returns
  * `mx.xls`: Macroeconomic and financial predictive covariates
  * `mz.xls`: Monitoring variables for dynamic rotation
  * `usrec.xls`: NBER recession binary indicator series
* Format: Excel 97-2003 Workbook (`.xls`) with embedded `information` metadata sheets
* Access: Publicly available datasets with zero proprietary or NDA restrictions

---

## 1.2 Target Price Series (my.xls)
* Column layout:
  * Column 1: Observation index
  * Column 2: Date in string format
  * Column 3: Nominal end-of-month spot price of WTI crude oil ($P_t$)
  * Column 4: Nominal return
  * Column 5: Real price of crude oil (adjusted by US CPI)
  * Column 6: Real return
  * Column 7: Numeric date identifier in `YYYYMM` format
* Target transformation in `main.m`:
  * Logarithmic differencing: $y_t = \ln P_t - \ln P_{t-1}$
  * De-meaning: sample mean centered using `funcMeanc`

---

## 1.3 Macroeconomic Predictors (mx.xls)
* Source: Federal Reserve Economic Data Monthly Database (FRED-MD)
* Sheet name: `Ark1`
* Predictor dimension: 122 macroeconomic and financial time series
* Missing value treatment:
  * Forward fill operation (lines 36-41 of `main.m`)
  * Any initial missing values imputed from subsequent available observations

---

## 1.4 Dynamic Rotation Monitoring Series (mz.xls)
* 18 monitoring time series corresponding to Table 1 of manuscript
* Stored in columns 1 through 19 (column 12 omitted from analysis)
* Standardized to match length of dependent variable regression matrix

---

## 1.5 Preprocessing and Transformation Pipeline
* Lag construction:
  * First lag ($p=1$) created via `funcLag.m`
  * Alignment adjusted for forecast horizon $h=1$
* Matrix assembly:
  * Regression design matrix: $X_{lag} = [y_{t-1}, X_{t-1}]$
  * Centered design matrix passed into RLS solver
* Constant term:
  * Accommodated via zero-variance benchmark model (vector of small constants $10^{-3}$)

---

## 1.6 Sample Splits and Evaluation Windows
* Estimation base window:
  * In-sample start date: `ib = 198601` (January 1986)
  * Full sample end date: `ie = 202412` (December 2024)
* Out-of-sample evaluation windows:
  * Full evaluation period: 1990m1 (`vbeg = 199001`) to 2024m12 (`vend = 202412`), total 420 monthly origins
  * Pre-COVID evaluation period: 1990m1 to 2019m12 (`vend = 201912`), total 360 monthly origins
