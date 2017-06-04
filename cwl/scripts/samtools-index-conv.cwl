#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [samtools, index]
inputs:
  input:
    type: File
    inputBinding:
      position: 1
  output:
    type: string
    inputBinding:
      position: 2
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)