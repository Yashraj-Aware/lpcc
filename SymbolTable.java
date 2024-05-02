import java.util.*;

public class SymbolTable
{
    public static void main(String[] args)
    {
        List<String> sourceCode = Arrays.asList(
                "START 180",          //
                "READ M",//180
                "READ N",//181
                "LOOP MOVER AREG, M",//182
                "MOVER BREG, N",//183
                "COMP BREG, ='200'",//184
                "BC GT, LOOP",//185
                "BACK SUB AREG, M",//186
                "COMP AREG, ='500'",//187
                "BC LT, BACK",//188
                "STOP",//189
                "M DS 1",//190
                "N DS 1",//200
                "END");//192

        Assembler assembler = new Assembler();
        assembler.assemble(sourceCode);
    }
}

class Assembler{
    private Map<String, Integer> symbolTable;
    private int locationCounter;
    

     Assembler()
    {
        symbolTable = new HashMap<>();
        
        locationCounter = 0;
         
    }

    void firstPass(List<String> sourceCode)
    {
        for(String line : sourceCode)
        {
            line = line.trim();
            if(line.startsWith("START"))
            {
                locationCounter = Integer.parseInt(line.split("\\s")[1]);
            }
            else if(line.startsWith("END"))
            {
                
                break;
            }
            
            else if(!line.isEmpty())
            {
                String[] parts = line.split("\\s");
                if(parts.length > 1 && !isInstruction(parts[0]))
                {

                    processLabel(line);
                }

                if(isInstruction(parts[0]) || parts[1].equals("DS"))
                {
                    locationCounter++;
                }
                
            }
        }
    }


    boolean isInstruction(String word)
    {
        Set<String> instructions = new HashSet<>(Arrays.asList(
            "START", "END", "READ", "MOVER", "ADD", "SUB", "COMP", "BC", "STOP","DS","LOOP"
        ));

        return instructions.contains(word);
    }


    void processLabel(String line)
    {
        String[] parts = line.split("\\s+");
        if(parts.length > 1 && !isInstruction(parts[0]))
        {

            String label = parts[0];
            symbolTable.put(label,locationCounter);
        }
    }



    void generateTables()
    {
        System.out.println("Symbol Tables:");
        System.out.println("Label\tAddress");

        for(Map.Entry<String,Integer> entry : symbolTable.entrySet())
        {
            System.out.println(entry.getKey() + "\t" + entry.getValue());
        }
    }

    void assemble(List<String> sourceCode)
    {
        firstPass(sourceCode);
        generateTables();
    }
}