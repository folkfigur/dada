import os
import hashlib
import glob
import json
def application(env, start_response):
        start_response('200 OK', [('Content-Type','text/html')])
        data="h"
        #data=env['wsgi.input'].readline().decode()
        data=env['wsgi.input'].read()
        # check that's a valid json
        json.loads(data)
        hashdigest = hashlib.sha256(data).hexdigest()
        with open("mint_"+hashdigest,"wb") as f: f.write(data)
        res={"queue":len(glob.glob("mint_*"))}

        return [json.dumps(res).encode("utf-8")]
