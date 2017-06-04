#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [samtools, mpileup]
inputs:
  reference:
    type: File
    inputBinding:
      position:1
      prefix: -f
      separate: true
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".bwt"
      - ".fai"
      - ".pac"
      - ".sa"
      - ^.dict
  norinput:
    type: File
    inputBinding:
      position: 2
  tumorinput:
    type: File
    inputBinding:
      position: 3
  output:
    type: string
    inputBinding:
      position: 4
      prefix: -o
      separate: true
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)
