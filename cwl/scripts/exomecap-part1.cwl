cwlVersion: cwl:draft-3
class: Workflow
inputs:
  - id: numInput1
    type: int
  - id: genomeInput1
    type: File
  - id: fastq_oneInput
    type: File
  - id: fastq_twoInput
    type: File
  - id: output1
    type: string
  - id: formatInput2
    type: int
  - id: qualityInput2
    type: int
  - id: output2
    type: string
  - id: output3
    type: string
  - id: qScore3
    type: int
  - id: nmSize3
    type: int
  - id: insertSize3
    type: int
  - id: numThreads4
    type: int
  - id: output4
    type: string
  - id: sortorder5
    type: string
  - id: output5
    type: string
  - id: valid5
    type: string
  - id: createind5
    type: boolean
  - id: output6
    type: string
  - id: metrics6
    type: string
  - id: createind6
    type: boolean
  - id: valid6
    type: string
  - id: removedup6
    type: boolean
  - id: output7
    type: string
  - id: rgid7
    type: int
  - id: rglb7
    type: string
  - id: rgpl7
    type: string
  - id: rgpu7
    type: string
  - id: rgsm7
    type: string
  - id: valid7
    type: string
  - id: output8
    type: string
  - id: reference8
    type: File
  - id: output9
    type: string
  - id: reference10
    type: File
  - id: numThreads10
    type: int
  - id: input10
    type: File
  - id: output10
    type: string
  - id: reference11
    type: File
  - id: targetIntervals11
    type: File
  - id: output11
    type: File
  - id: output12
    type: string
  - id: so12
    type: string
  - id: validation12
    type: string
  - id: index12
    type: boolean

        

outputs:
  - id: workflowOutput
    type: File
    source: "#gatk-RealignerTargetCreator/result"


steps:
 - id: bwa-mem
   run: bwa-mem.cwl
   inputs:
      - id: numthreads
        source: "#numInput1"
      - id: genome
        source: "#genomeInput1"
      - id: fastq_one
        source: "#fastq_oneInput"
      - id: fastq_two
        source: "#fastq_twoInput"
      - id: output
        source: "#output1"
   outputs:
      - id: result


 - id: samtool
   run: samtools-view.cwl
   inputs:
      - id: format
        source: "#formatInput2"
      - id: quality
        source: "#qualityInput2"
      - id: input
        source: "#bwa-mem/result"
      - id: output
        source: "#output2"
   outputs:
      - id: result 

 - id: samtool
   run: samCheckInsertNM.cwl
   inputs:
      - id: input
        source: "#samtool/result"
      - id: output
        source: "#output3"
      - id: qScore
        source: "#qScore3"
      - id: nmSize
        source: "#nmSize3"
      - id: insertSize
        source: "#insertSize3"
   outputs:
      - id: result  

 - id: samtool-conv
   run: samtools-view-conv.cwl
   inputs:
      - id: numThreads
        source: "#numThreads4"
      - id: input
        source: "#bwa-mem/result"
      - id: output
        source: "#output4"
   outputs:
      - id: result

 - id: picard-Sort
   run: picard-SortSam.cwl
   inputs:
      - id: sortorder
        source: "#sortorder5"
      - id: input
        source: "#samtool-conv/result"
      - id: output
        source: "#output5"
      - id: valid
        source: "#valid5"
      - id: createind
        source: "#createind5"
   outputs:
      - id: result

 - id: picard-MarkDup
   run: picard-MarkDuplicates.cwl
   inputs:
      - id: input
        source: "#picard-Sort/result"
      - id: output
        source: "#output6"
      - id: metrics
        source: "#metrics6"
      - id: createind
        source: "#createind6"
      - id: valid
        source: "#valid6"
      - id: removedup
        source: "#removedup6"
   outputs:
      - id: result

 - id: picard-AddorRep
   run: picard-AddOrReplaceReadGroups.cwl
   inputs:
      - id: input
        source: "#picard-MarkDup/result"
      - id: output
        source: "#output7"
      - id: rgid
        source: "#rgid7"
      - id: rglb
        source: "#rglb7"
      - id: rgpl
        source: "#rgpl7"
      - id: rgpu
        source: "#rgpu7"
      - id: rgsm
        source: "#rgsm7"
      - id: valid
        source: "#valid7"
   outputs:
      - id: result

 - id: picard-ReorderSam
   run: picard-ReorderSam.cwl
   inputs:
      - id: input
        source: "#picard-AddorRep/result"
      - id: output
        source: "#output8"
      - id: reference
        source: "#reference8"
   outputs:
      - id: result


 - id: samtoolsIndex
   run: samtools-index.cwl
   inputs:
      - id: input
        source: "#picard-ReorderSam/result"
      - id: output
        source: "#output9"
   outputs:
      - id: result

 - id: gatk-RealignerTargetCreator
   run: gatk-RealignerTargetCreator.cwl
   inputs:
      - id: reference
        source: "#reference10"
      - id: numThreads
        source: "#numThreads10"
      - id: input
        source: "#input10"
      - id: output
        source: "#output10"
   outputs:
      - id: result

 - id: gatk-IndelRealigner
   run: gatk-IndelRealigner.cwl
   inputs:
      - id: input
        source: "#gatk-RealignerTargetCreator/result"
      - id: reference
        source: "#reference11"
      - id: targetIntervals
        source: "#numThreads11"
      - id: output
        source: "#output11"
   outputs:
      - id: result

 
  - id: gatk-FixMateInformation
   run: gatk-FixMateInformation.cwl
   inputs:
      - id: input
        source: "#gatk-IndelRealigner/result"
      - id: output
        source: "#output12"
      - id: so
        source: "#so12"
      - id: validation
        source: "#validation12"
      - id: index
        source: "#index12"
   outputs:
      - id: result 
  
