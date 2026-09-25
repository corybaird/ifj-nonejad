# System Architecture and Econometric Specifications

## 1. Table of Contents
* 1.1 Mathematical Pipeline and DAG
* 1.2 Dynamic Linear Models and Recursive Least Squares
* 1.3 Dynamic Forecast Rotation Mechanism
* 1.4 Bayesian Beta-Binomial Learning Algorithm
* 1.5 Forecast Evaluation and Loss Metrics

---

## 1.1 Mathematical Pipeline and DAG
* Stage 0 (Data Layer):
  * WTI prices and log returns ($y_t = \Delta \ln P_t$) from `my.xls`
  * Macroeconomic predictors ($X_t$) from `mx.xls`
  * Monitoring series ($z_t$) from `mz.xls`
  * NBER recession indicators from `usrec.xls`
* Stage 1 (Base Forecasting Models):
  * Individual predictive regressions estimated via RLS with forgetting factor $\lambda$
  * Benchmark random-walk model without drift
* Stage 2 (Dynamic Forecast Rotation):
  * Extreme-value filter on historical loss differentials ($v_L$) and monitoring series ($v_h$)
  * Dynamic rotation indicator generation ($I_t \in \{0, 1\}$)
* Stage 3 (Bayesian Probability Learning):
  * Beta-binomial conjugate updating over time-varying activation states
  * Grid search over shrinkage parameters ($\delta, \kappa$)
* Stage 4 (Evaluation & Loss):
  * Real-time point forecast generation
  * Theil's U, Clark-West, Diebold-Mariano tests, and regulatory downside loss

---

## 1.2 Dynamic Linear Models and Recursive Least Squares
* Base regression specification:
  * $y_{t+h} = \alpha_i + \beta_i' x_{i,t} + \varepsilon_{t+h}$
* Recursive updating with discounting:
  * State covariance update: $R_t = \frac{1}{\lambda} R_{t-1} + x_t x_t'$
  * Gain matrix: $K_t = R_t^{-1} x_t$
  * Parameter update: $\theta_t = \theta_{t-1} + K_t (y_t - x_t' \theta_{t-1})$
* Hyperparameter combinations:
  * Forgetting factor vector: $\lambda \in [0.94, 1.00]$ in steps of 0.01
  * Variance parameter: $g = 50$
  * Total grid size: 7 parameter pairs
* Contrast with DSGE MCMC: no Metropolis-Hastings chains or sampling proposals; all updates are deterministic analytical recursions

---

## 1.3 Dynamic Forecast Rotation Mechanism
* Framework of Zhu and Timmermann (2022)
* Loss differential:
  * $\Delta L_{t,m} = L(e_{t,BM}) - L(e_{t,m})$
* Extreme value thresholding:
  * Lookback window: $K = 36$ months ($3 \times 12$)
  * Filtered loss: $g_t = \max(0, \Delta L_t - \max_{k} \Delta L) + \min(0, \Delta L_t - \min_{k} \Delta L)$
  * Filtered monitor: $g_{c,t} = \max(0, z_t - \max_{k} z) + \min(0, z_t - \min_{k} z)$
* Rotation regression:
  * $\Delta L_{t+h,m} = \gamma_0 + \gamma_1 g_t + \gamma_2 g_{c,t} + u_{t+h}$
  * Binary rotation trigger: $d_{t,m} = \mathbf{1}(\widehat{\Delta L}_{t+h,m} > 0)$

---

## 1.4 Bayesian Beta-Binomial Learning Algorithm
* State transition updating:
  * Number of successes: $k_t = \sum_{j=1}^m d_{t,j}$
  * Number of trials: $m$ active predictive models
* Conjugate Beta prior:
  * Prior distribution: $\theta_t \sim \text{Beta}(a_{t-1}, b_{t-1})$
  * Posterior distribution: $\theta_t | k_t \sim \text{Beta}(a_{t-1} + k_t, b_{t-1} + m - k_t)$
* Exponential memory discounting:
  * $a_t = \delta a_{t-1} + k_t$
  * $b_t = \delta b_{t-1} + m - k_t$
  * Discount factor: $\delta \in (0, 1]$ controlling memory depth
* Predictive model combination:
  * Real-time probability weight assigned to predictive combination versus random-walk benchmark

---

## 1.5 Forecast Evaluation and Loss Metrics
* Relative Mean Squared Error:
  * Theil's U: $\text{TU} = \frac{\text{MSE}_{\text{model}}}{\text{MSE}_{\text{RW}}}$
* Hypothesis tests:
  * Clark and West (2007) MSPE-adjusted test for nested specifications
  * Diebold and Mariano (1995) test for non-nested comparison
  * Newey-West HAC covariance estimation with lag selection $H = h$
* Economic value evaluation:
  * Regulatory loss function under asymmetric shortfall penalty
  * Value-at-Risk (VaR) and Expected Shortfall (ES) at $\alpha = 0.05$
  * Annualized Sharpe ratio comparison based on volatility-timed trading strategies
