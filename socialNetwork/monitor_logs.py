import re
from subprocess import Popen, PIPE, getoutput
from typing import List, Union
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime


def get_services(namespace: str) -> List[str]:
    p = Popen(
        f"kubectl get -n {namespace} svc "
        "| awk '{print $1}' "
        "| grep -v 'NAME'| grep -v 'es.*' | grep -v 'jaeger.*' | grep -v 'kbn.*'",
        shell=True,
        stdout=PIPE,
    )
    stdout, _ = p.communicate()
    return stdout.decode().splitlines(keepends=False)


def errors_in_logs(namespace: str, svc: str) -> Union[None, str]:
    log = getoutput(f"kubectl logs --since=10m -n {namespace} svc/{svc}")
    match_list = re.findall(
        "((error)|(exception)|(broken))",
        log.lower()
    )
    if len(match_list) > 0:
        return f"{namespace} svc/{svc}:\n{log}"
    else:
        return None


def main():
    namespace = 'social-network'
    email = "li_zeyan@icloud.com"
    services = get_services(namespace)
    with ThreadPoolExecutor(max_workers=8) as pool:
        errors_logs = "\n\n================================\n\n".join(filter(
            lambda _: _ is not None,
            pool.map(lambda _: errors_in_logs(namespace, _), services)
        ))
    if errors_logs != "":
        print(f"send to {email}")
        cmd = f'mail ' \
              f'-a "From: {namespace} monitor <{namespace}-monitor@peidan.me>" ' \
              f' -s "{datetime.now().isoformat()} Error detected in logs in {namespace}" ' \
              f' --content-type "text/plain" ' \
              f' {email}'
        send_mail = Popen(
            cmd,
            shell=True,
            stdin=PIPE
        )
        _message = errors_logs
        send_mail.communicate(
            _message.encode('utf-8')
        )
        send_mail.poll()
    else:
        print(f"{datetime.now().isoformat()} no error detected")


if __name__ == '__main__':
    main()
