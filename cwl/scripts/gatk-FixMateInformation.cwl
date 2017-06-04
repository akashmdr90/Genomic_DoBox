cwlVersion: v1.0

class: CommandLineTool
baseCommand: java
arguments:
  - valueFrom: -Xmx64g
    position: 1
  - valueFrom: /usr/local/lib/picard/picard.jar
    position: 2
    prefix: -jar
  - valueFrom: FixMateInformation 
    position: 3

inputs:
  input:
    type: File
    inputBinding:
      position: 4
      prefix: INPUT=
      separate: false
  output:
    type: string
    inputBinding:
      position: 5
      prefix: OUTPUT=
      separate: false
  so:
    type: string
    inputBinding:
      position: 7
      prefix: SO=
      separate: false
  validation:
    type: string
    inputBinding:
      position: 7
      prefix: VALIDATION_STRINGENCY=
      separate: false
  index:
    type: boolean
    inputBinding:
      position: 7
      prefix: CREATE_INDEX=
      separate: false
outputs: 
  result:
    type: File
    outputBinding:
      glob: $(inputs.output)