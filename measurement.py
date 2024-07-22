from codecarbon import EmissionsTracker
import numpy as np

tracker = EmissionsTracker()
tracker.start()
try:
     # Compute intensive code goes here
     for idx in range(5):
          a = np.random.randn(10000, 10000)
          b = np.random.randn(10000, 10000)
          c = a*b
finally:
     tracker.stop()