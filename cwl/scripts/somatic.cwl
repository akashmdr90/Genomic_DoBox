#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: java
arguments:
  - valueFrom: -Xmx64g
    position: 1
  - valueFrom: /usr/local/lib/varscan/VarScan.v2.3.9.jar 
    position: 2
    prefix: -jar
  - valueFrom:  somatic
    position: 3

inputs:
  input:
    type: File
    inputBinding:
      position: 4
  output:
    type: string
    inputBinding:
      position: 5
  mpileup:
    type: int
    inputBinding:
      position: 6
      prefix: --mpileup
      separate: true 
  min-coverage:
    type: int
    inputBinding:
      position: 7
      prefix: --min-coverage
      separate: true
  min-var-freq:
    type: int
    inputBinding:
      position: 8
      prefix: --min-var-freq
      separate: true 
  output-vcf:
    type: int
    inputBinding:
      position: 9
      prefix: --output-vcf
      separate: true 
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)