context("classif_bartMachine")

test_that("classif_bartMachine", {
  library(bartMachine)
  parset.list = list(
    list(num_burn_in = 20L, num_iterations_after_burn_in = 50L),
    list(num_burn_in = 20L, num_iterations_after_burn_in = 50L, alpha = 0.8, num_trees = 25L)
  )

  old.predicts.list = list()
  old.probs.list = list()

  for (i in 1:length(parset.list)) {
    parset = parset.list[[i]]
    x = binaryclass.train
    y = x[, binaryclass.class.col]
    x[, binaryclass.class.col] = NULL
    pars = list(X = x, y = y, verbose = FALSE)
    pars = c(pars, parset)
    set.seed(getOption("mlr.debug.seed"))
    m = do.call(bartMachine, pars)
    newx = binaryclass.test
    newx[, binaryclass.class.col] = NULL
    set.seed(getOption("mlr.debug.seed"))
    p = predict(m, new_data = newx, type = "class")
    set.seed(getOption("mlr.debug.seed"))
    p2 = predict(m, new_data = newx, type = "prob")
    destroy_bart_machine(m)
    old.predicts.list[[i]] = p
    old.probs.list[[i]] = p2
  }

  # FIXME:
  #Does not yet work because we can not yet set the seed for bartMachine, see
  #https://github.com/kapelner/bartMachine/issues/2
  #testSimpleParsets("classif.bartMachine", binaryclass.df, binaryclass.target, binaryclass.train.inds,
  #  old.predicts.list, parset.list)
  #testProbParsets ("classif.bartMachine", binaryclass.df, binaryclass.target, binaryclass.train.inds,
  #  old.probs.list, parset.list)

  for(i in 1:length(parset.list)){
    expect_true(length(old.predicts.list[[i]]) == nrow(binaryclass.test))
    expect_true(length(old.probs.list[[i]]) == nrow(binaryclass.test))
  }

})