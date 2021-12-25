import pickle, os, sys
from pathlib import Path

portals = {}

if not os.path.exists(str(Path.home())+"/.config/portal_config/portals.pickle"):
    pickle.dump(portals,open(str(Path.home())+"/.config/portal_config/portals.pickle","wb"))
else:
    portals = pickle.load(open(str(Path.home())+"/.config/portal_config/portals.pickle","rb"))

if sys.argv[1] == "-E":
    if sys.argv[2] in portals.keys():
        sys.exit(1)
    else:
        sys.exit(2)
elif sys.argv[1] == "-W":
    portals[sys.argv[2]] = sys.argv[3]
    pickle.dump(portals,open(str(Path.home())+"/.config/portal_config/portals.pickle","wb"))
elif sys.argv[1] == "-R":
    if sys.argv[2] in portals.keys():
        print(portals[sys.argv[2]])
        sys.exit(0)
    else:
        sys.exit(1)
elif sys.argv[1] == "-L":
    for key in portals.keys():
        print(f"{key}: {portals[key]}")
elif sys.argv[1] == "-D":
    del portals[sys.argv[2]]
    pickle.dump(portals,open(str(Path.home())+"/.config/portal_config/portals.pickle","wb"))

