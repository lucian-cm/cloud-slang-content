#   (c) Copyright 2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Schedules Jenkins job to be built.
#! @prerequisites: jenkinsapi Python module
#!
#! @input url: URL to Jenkins
#! @input job_name: name of job to build
#!
#! @output result_message: operation results
#!
#! @result SUCCESS: return code is 0
#! @result FAILURE: otherwise
#!!#
########################################################################################################################

namespace: io.cloudslang.jenkins

operation:
  name: invoke_job

  inputs:
    - url
    - job_name

  python_action:
    script: |
      try:
        from jenkinsapi.jenkins import Jenkins
        j = Jenkins(url, '', '')

        job = j.get_job(job_name)
        job.invoke()

        return_code = '0'
        result_message = 'Success'
      except:
        return_code = '-1'
        result_message = 'Error while enabling job: ' + job_name

  outputs:
    - result_message

  results:
    - SUCCESS: ${ return_code == '0' }
    - FAILURE
