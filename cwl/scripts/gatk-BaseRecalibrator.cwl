#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: java
arguments:
  - valueFrom: -Xmx64g
    position: 1
  - valueFrom: /usr/local/lib/gatk/GenomeAnalysisTK.jar
    position: 2
    prefix: -jar
  - valueFrom:  BaseRecalibrator
    position: 3
    prefix: -T
inputs:
  numThreads:
    type: int
    inputBinding:
      position: 4
      prefix: -nct
      separate: true 
  reference:
    type: File
    inputBinding:
      position: 5
      prefix: -R
      separate: true
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".bwt"
      - ".fai"
      - ".pac"
      - ".sa"
      - ^.dict
  input:
    type: File
    inputBinding:
      position: 6
      prefix: -I
      separate: true
  Sites:
    type: string
    inputBinding:
      position: 7
      prefix: -knownSites 
      separate: true
  output:
    type: string
    inputBinding:
      position: 8
      prefix: -o
      separate: true
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)