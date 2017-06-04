#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: perl
arguments:
  - valueFrom: /usr/local/lib/perl/samCheckInsertNM.pl
    position: 1
inputs:
  input:
    type: File
    inputBinding:
      position: 2
      prefix: --input=
      separate: false
  output:
    type: string
    inputBinding:
      position: 3
      prefix: --output=
      separate: false
  qScore:
    type: int
    inputBinding:
      position: 5
      prefix: --qScore=
      separate: false 
  nmSize:
    type: int
    inputBinding:
      position: 6
      prefix: --nmSize=
      separate: false 
  insertSize:
    type: int
    inputBinding:
      position: 7
      prefix: --insertSize=
      separate: false 
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)
