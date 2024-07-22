from codecarbon import EmissionsTracker
import numpy as np

with EmissionsTracker(project_name="large") as tracker:
     # Compute intensive code goes here
     for idx in range(10):
          print(idx)
          a = np.random.randn(10000, 10000)
          b = np.random.randn(10000, 10000)
          c = a*b

with EmissionsTracker(project_name="medium") as tracker:
     # Compute intensive code goes here
     for idx in range(10):
          print(idx)
          a = np.random.randn(1000, 1000)
          b = np.random.randn(1000, 1000)
          c = a*b

with EmissionsTracker(project_name="small") as tracker:
     # Compute intensive code goes here
     for idx in range(10):
          print(idx)
          a = np.random.randn(10, 10)
          b = np.random.randn(10, 10)
          c = a*b