{-# LANGUAGE ImportQualifiedPost #-}
module Main where

import Control.Monad
import System.Exit
import ShellCheck.Analytics qualified
import ShellCheck.AnalyzerLib qualified
import ShellCheck.ASTLib qualified
import ShellCheck.CFG qualified
import ShellCheck.CFGAnalysis qualified
import ShellCheck.Checker qualified
import ShellCheck.Checks.Commands qualified
import ShellCheck.Checks.ControlFlow qualified
import ShellCheck.Checks.Custom qualified
import ShellCheck.Checks.ShellSupport qualified
import ShellCheck.EditorConfig qualified
import ShellCheck.Fixer qualified
import ShellCheck.Formatter.Diff qualified
import ShellCheck.Parser qualified

main = do
    putStrLn "Running ShellCheck tests..."
    failures <- filter (not . snd) <$> mapM sequenceA tests
    if null failures then exitSuccess else do
      putStrLn "Tests failed for the following module(s):"
      mapM (putStrLn . ("- ShellCheck." ++) . fst) failures
      exitFailure
  where
    tests =
      [ ("Analytics"          , ShellCheck.Analytics.runTests)
      , ("AnalyzerLib"        , ShellCheck.AnalyzerLib.runTests)
      , ("ASTLib"             , ShellCheck.ASTLib.runTests)
      , ("CFG"                , ShellCheck.CFG.runTests)
      , ("CFGAnalysis"        , ShellCheck.CFGAnalysis.runTests)
      , ("Checker"            , ShellCheck.Checker.runTests)
      , ("Checks.Commands"    , ShellCheck.Checks.Commands.runTests)
      , ("Checks.ControlFlow" , ShellCheck.Checks.ControlFlow.runTests)
      , ("Checks.Custom"      , ShellCheck.Checks.Custom.runTests)
      , ("Checks.ShellSupport", ShellCheck.Checks.ShellSupport.runTests)
      , ("EditorConfig"       , ShellCheck.EditorConfig.runTests)
      , ("Fixer"              , ShellCheck.Fixer.runTests)
      , ("Formatter.Diff"     , ShellCheck.Formatter.Diff.runTests)
      , ("Parser"             , ShellCheck.Parser.runTests)
      ]
