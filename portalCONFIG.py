import os, sys, pickle

config = {"flavor_messages": True}

if not os.path.exists("/bin/portal_bin/config.pickle"):
    pickle.dump(config,open("/bin/portal_bin/config.pickle","wb"))
else:
    config = pickle.load(open("/bin/portal_bin/config.pickle", "rb"))

if sys.argv[1] in config:
    config[sys.argv[1]] = not config[sys.argv[1]]
    pickle.dump(config,open("/bin/portal_bin/config.pickle","wb"))
elif sys.argv[1] == "-r" and len(sys.argv) == 2:
    for key in config:
        print(f"{key}: {config[key]}")
elif sys.argv[1] == "-e" and sys.argv[2] != "":
    if sys.argv[2] in config:
        sys.exit(0)
    else:
        sys.exit(1)
elif sys.argv[1] == "-r" and sys.argv[2] != "":
    if config[sys.argv[2]] == True:
        sys.exit(0)
    else:
        sys.exit(1)
