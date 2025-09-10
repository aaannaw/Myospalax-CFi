import sys
import glob
infiles = glob.glob("./K2P_result/*.k2p")
outfile = sys.argv[1]

with open (outfile, "w") as f1:
    #f1.write("cds_name  deer    golden  GY  Jaculus mouse   rat Rhizomys    ZH  spalax"
    for infile in infiles:
        American_beaver = 0
        Bamboo_rat = 0
        Chinese_hamster = 0
        Efon = 0
        Egyptian_jerboa = 0
        Golden_hamster = 0
        Guinea_pig = 0
        Ma = 0
        Mp = 0
        Prairie_deer_mouse= 0
        Rat = 0
        Spalax = 0
        with open (infile, "r") as f2:
            for line in f2:
                line = line.strip().split("\t")
                if line [1] == "American_beaver" or line[3] == "American_beaver":
                    American_beaver += float(line[4])
                if line [1] == "Bamboo_rat" or line[3] == "Bamboo_rat":
                    Bamboo_rat += float(line[4])
                if line [1] == "Chinese_hamster" or line[3] == "Chinese_hamster":
                    Chinese_hamster += float(line[4])
                if line [1] == "Efon" or line[3] == "Efon":
                    Efon += float(line[4])
                if line [1] == "Egyptian_jerboa" or line[3] == "Egyptian_jerboa":
                    Egyptian_jerboa += float(line[4])
                if line [1] == "Golden_hamster" or line[3] == "Golden_hamster":
                    Golden_hamster += float(line[4])
                if line [1] == "Guinea_pig" or line[3] == "Guinea_pig":
                    Guinea_pig += float(line[4])
                if line [1] == "Ma" or line[3] == "Ma":
                    Ma += float(line[4])
                if  line [1] == "Mp" or line[3] == "Mp":
                    Mp += float(line[4])
                if line [1] == "Prairie_deer_mouse" or line[3] == "Prairie_deer_mouse":
                    Prairie_deer_mouse += float(line[4])
                if line [1] == "Rat" or line[3] == "Rat":
                    Rat += float(line[4])
                if line [1] == "Spalax" or line[3] == "Spalax":
                    Spalax += float(line[4])
            American_beaver = American_beaver/12
            Bamboo_rat = Bamboo_rat/12
            Chinese_hamster = Chinese_hamster/12
            Efon = Efon/12
            Egyptian_jerboa = Egyptian_jerboa/12
            Golden_hamster = Golden_hamster/12
            Guinea_pig = Guinea_pig/12
            Ma = Ma/12
            Mp = Mp/12
            Prairie_deer_mouse = Prairie_deer_mouse/12
            Rat = Rat/12
            Spalax = Spalax/12
            f1.write('American_beaver\t'+str(American_beaver)+"\n"+'Bamboo_rat\t'+str(Bamboo_rat)+"\n"+'Chinese_hamster\t'+str(Chinese_hamster)+"\n"+'Efon\t'+str(Efon)+"\n"+'Egyptian_jerboa\t'+str(Egyptian_jerboa)+"\n"+'Golden_hamster\t'+str(Golden_hamster)+"\n"+'Guinea_pig\t'+str(Guinea_pig)+"\n"+'Ma\t'+str(Ma)+"\n"+'Mp\t'+str(Mp)+"\n"+'Prairie_deer_mouse\t'+str(Prairie_deer_mouse)+"\n"+'Rat\t'+str(Rat)+"\n"+'Spalax\t'+str(Spalax)+"\n")
