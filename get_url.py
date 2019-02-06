#!/usr/bin/env python

import os
import sys
import json

if __name__ == '__main__':
  env = sys.argv[1]
  with open(env) as fp:
    obj = json.load(fp)
  print(f"{obj['protocol']}://{obj['host']}:8888{obj['base_url']}?{obj['token']}")	
