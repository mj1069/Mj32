##MJ32 - RISC V Processor

#Introduction:  

In the realm of processor architecture, this project delves into the meticulous design and realization of a 32-bit processor core adhering to the RISC-V 32I ISA. The RISC-V architecture, known for its simplicity and versatility, serves as the foundational framework, encompassing the initial 37 instructions from the base instruction set. This endeavor stands as a testament to the intricate interplay between hardware design, assembly language, and simulation technologies.

The processor core design is executed in Verilog, a hardware description language, with the customasm assembler providing flexibility and customizability. Simulation is facilitated through EDA playground and iVerilog, while the Digital open-source logic designer and simulator serve as the principal platform for comprehensive testing.

The core architecture shuns the complexities of a pipelined structure, opting for a straightforward approach of executing a single instruction per cycle. Memory management is bifurcated into separate 32-bit addressable spaces for program and data, each serviced by dedicated buses to optimize data transfer efficiency.

Decoding instructions is a pivotal task handled by a dedicated decoder, which identifies instruction types based on the opcode. The subsequent routing of instructions to specific decoders ensures precise control signal generation and data retrieval from registers and memory. Execution units, in turn, manipulate the acquired data to compute results, which are then written back to registers or memory, as dictated by the instruction.

Exception handling is streamlined through the incorporation of default states within each unit, ensuring a prompt and consistent response to exceptional scenarios. While interrupts are omitted from consideration, the design prioritizes robust exception handling mechanisms.

In the context of testing, a meticulous strategy is adopted with separate testbenches for individual units and a comprehensive overall testbench. The Digital logic designer and simulator serve as the workhorse for simulation and testing, allowing for a detailed and rigorous examination of the processor core's functionality.

It is imperative to note that the scope of this project is confined to simulation, precluding considerations for clock frequency optimization. The ensuing sections delve into the specifics of the design, implementation, and testing, providing a comprehensive overview of the 32-bit processor core's architecture and functionality.

#Introduction to RISC-V and 32I ISA:  

RISC-V, a burgeoning and open-source instruction set architecture (ISA), has emerged as a pivotal player in the dynamic landscape of processor design. Notable for its simplicity, modularity, and adaptability, RISC-V stands as an open standard, facilitating innovation and collaboration in the realm of computer architecture. Developed at the University of California, Berkeley, RISC-V's design philosophy revolves around a reduced instruction set computing (RISC) approach, emphasizing streamlined instruction sets to enhance overall performance.

The RISC-V ISA is structured into different subsets, each catering to specific application domains and hardware requirements. In this project, the focus is on the RISC-V 32I ISA, which constitutes the base integer instruction set. This subset encompasses the fundamental instructions necessary for integer arithmetic and logical operations, providing a solid foundation for general-purpose computing.

The RISC-V 32I ISA is characterized by a 32-bit architecture, aligning with the prevailing trend in contemporary processor designs. With a carefully curated selection of instructions, the 32I ISA strikes a balance between simplicity and versatility, making it an ideal choice for educational purposes, research, and the development of efficient and scalable processor cores.

This project embarks on the intricate journey of harnessing the potential of RISC-V 32I ISA, aiming to construct a 32-bit processor core that encapsulates the essence of RISC-V's design principles. By leveraging the specified instruction set, this endeavor seeks to embody the efficiency, flexibility, and elegance that define RISC-V architectures, contributing to the ongoing discourse in the ever-evolving field of computer architecture.

#Customasm in RISC-V Processor Design:  

#Introduction: 
In the realm of RISC-V processor design, the choice of an assembler plays a critical role in streamlining the development process and enhancing configurability. Customasm, an open-source and customizable assembler, emerges as a pivotal tool for the project's 32-bit processor core implementation. Developed by hlorenzi and available on GitHub, Customasm provides a flexible and extensible platform for translating human-readable assembly code into machine code, tailored to the specific needs of the project.

#Key Features and Functionality: 
Customasm's primary strength lies in its adaptability and configurability, allowing developers to define and customize their instruction set architecture (ISA) seamlessly. Leveraging Customasm facilitates the translation of assembly code written in the RISC-V ISA into machine code, ensuring compatibility with the targeted processor core. This level of customization proves instrumental in aligning the assembler with the specific subset of instructions chosen for the project, which encompasses the initial 37 instructions of the RISC-V 32I ISA.

The assembler supports a modular and plugin-based architecture, enabling users to extend its functionality to meet project-specific requirements. This extensibility ensures that the assembler can evolve alongside the project's needs, accommodating changes or additions to the instruction set with ease. The project benefits from Customasm's capacity to generate machine code in a format compatible with the Verilog hardware description language, facilitating a seamless integration into the overall design and implementation workflow.

#Advantages for Project Development: 
Customasm serves as a bridge between the high-level assembly code and the low-level hardware description, aiding in the smooth translation of the project's RISC-V assembly instructions into executable machine code. The customization capabilities empower the project to embrace a tailored subset of the RISC-V ISA, streamlining the development process and enhancing overall project manageability.

The GitHub repository for Customasm (https://github.com/hlorenzi/customasm) serves as a central hub for project documentation, updates, and community engagement. The transparent and collaborative nature of open-source development ensures that any queries or modifications related to Customasm can be addressed within the wider community, fostering a collaborative environment for RISC-V processor designers.

#Conclusion: 
Incorporating Customasm into the project's toolchain not only aligns with the principles of openness and customization inherent in RISC-V architecture but also empowers the development process with a versatile and adaptable assembler. The extensibility, modular architecture, and compatibility with the project's chosen subset of instructions make Customasm a valuable asset in the implementation of the 32-bit processor core. As the project progresses, Customasm stands as a dynamic tool, ready to evolve in tandem with the changing requirements and intricacies of the RISC-V processor design landscape.

#Digital - Logic Designer and Simulator in RISC-V Processor Design:  

#Introduction: 
In the landscape of RISC-V processor design, the tooling chosen for simulation and testing is paramount. Digital, a versatile open-source logic designer and simulator developed by hneemann, emerges as a powerful asset in the implementation of the project's 32-bit processor core. The tool boasts an array of features tailored for effective circuit analysis, synthesis, and visualization. Its adaptability, performance, and debugging capabilities make it a valuable addition to the project's toolchain.

#Key Features: 
Digital's feature set caters to a diverse range of needs in the context of RISC-V processor design:

1.   Visualization and Measurement:   Digital facilitates the visualization of signal states through measurement graphs, aiding in the analysis of circuit behavior.

2.   Single Gate Mode:   Enables the analysis of oscillations at the gate level, providing detailed insights into circuit dynamics.

3.   Combinatorial and Sequential Circuit Analysis:   Supports the analysis and synthesis of both combinatorial and sequential circuits, offering flexibility in circuit design.

4.   Circuit Testing:   Allows the creation of test cases for thorough testing and verification of circuit designs, ensuring robust functionality.

5.   Library of Components:   Includes a library with commonly used 74xx series integrated circuits, streamlining the integration of standard components into designs.

6.   Performance:   Exhibits good performance, with the ability to clock a simple processor at 120 kHz, making it suitable for a variety of applications.

7.   Export and Integration:   Enables the export of circuits to VHDL or Verilog for integration with FPGA platforms. Additionally, direct export of JEDEC files facilitates flashing to GAL16v8 or GAL22v10 chips for hardware testing.

8.   Debugging Interface:   Offers a simple TCP-based remote control interface for seamless integration with assembler IDEs, enhancing the debugging capabilities of simulated processors.

#Motivation Behind Development: 
Digital's development arose from the need for a robust and actively developed simulator following the discontinuation of Logisim, a popular tool for teaching purposes. The motivation to embark on Digital's development stemmed from addressing architectural weaknesses in Logisim that proved challenging to overcome. Unlike some forks of Logisim that focus on feature additions and bug fixes, Digital sought to tackle the underlying architectural difficulties, resulting in a new simulator that surpasses Logisim in various aspects, including performance, testing capabilities, and hardware support.

#Simulator Architecture: 
Digital introduces the concept of "switching on" a circuit to address simulation challenges encountered in Logisim. The simulation operates in an event-based mode during the settling time after circuit activation, ensuring a stable state is reached. The tool's ability to handle oscillations and propagate signal changes gate by gate in single gate mode enhances the debugging capabilities, providing a deeper understanding of circuit behavior.

#Performance and Debugging: 
Digital's performance, illustrated by its ability to simulate a complete processor with a 120 kHz clock, is a notable advantage. The tool's debugging interface allows for seamless interaction with assembler IDEs, making it easier to debug assembly programs in a simulated processor. The incorporation of break gates and the ability to insert breakpoints through assembly instructions further simplifies the debugging process.

#Circuit Synthesis and Export: 
Digital's support for circuit synthesis, including the generation of combinatorial circuits from truth tables and sequential circuits from state transition tables, enhances its utility for educational purposes. The direct export of circuits to VHDL, Verilog, and JEDEC files facilitates hardware testing on GAL chips or integration with FPGA platforms.

#Conclusion: 
Digital, with its rich feature set, robust architecture, and commitment to addressing the limitations of existing tools, emerges as a valuable companion in the development and testing of the project's 32-bit processor core. Its adaptability, performance, and emphasis on addressing simulation challenges make it a powerful tool in the RISC-V processor design toolkit, aligning seamlessly with the project's goals of efficiency and educational value. The tool's continued development and commitment to overcoming architectural challenges position it as a noteworthy choice for simulation and testing in the realm of digital logic design.

#EDA Playground in RISC-V Processor Design:  

#Introduction: 
In the realm of RISC-V processor design, the choice of Electronic Design Automation (EDA) tools plays a crucial role in facilitating the development, simulation, and verification processes. EDA Playground, an online platform for EDA tool access, proves to be a valuable resource for the project's 32-bit processor core implementation. This cloud-based platform offers a convenient and collaborative environment, enabling users to design and simulate circuits using various tools without the need for local installations.

#Features and Capabilities: 
EDA Playground provides a range of features and capabilities that contribute to its effectiveness in the context of RISC-V processor design:

#Cloud-Based Access: 
EDA Playground operates in the cloud, allowing users to access a variety of EDA tools directly from a web browser. This eliminates the need for local installations and provides a seamless, platform-independent experience.

#Simulation and Verification:
Users can simulate and verify their designs using different EDA tools available on the platform. This includes running simulations to assess the functionality and performance of the designed RISC-V processor core.

#Multi-Language Support:
EDA Playground supports multiple hardware description languages (HDLs) such as Verilog, SystemVerilog, and VHDL. This flexibility accommodates various design preferences and requirements.

#Collaborative Environment:
The platform fosters collaboration by allowing users to share their designs and simulations with others. This feature is particularly valuable for educational purposes, facilitating teamwork and knowledge sharing.

#Quick Prototyping:
EDA Playground enables rapid prototyping and testing of circuit designs. Users can iterate on their RISC-V processor core implementations efficiently, making it a valuable tool for design exploration.

#Tool Integration:
The platform integrates with popular EDA tools, providing users with a choice of tools for simulation and synthesis. This integration enhances the versatility of the platform, catering to a wide range of design needs.

#Educational Use:
EDA Playground's accessibility and ease of use make it an excellent resource for educational purposes. It allows students and learners to experiment with digital design concepts, including the implementation and simulation of RISC-V processor cores.

#Usage in the Project: 
The project leverages EDA Playground for various stages of the RISC-V processor core implementation:

1.   Design Exploration:   EDA Playground facilitates the exploration of different design options and configurations for the 32-bit processor core. Designers can quickly prototype and simulate variations to assess their impact on performance and functionality.

#Educational Testing
The platform is utilized for educational testing, enabling students or team members to interact with and test the RISC-V processor core in a collaborative online environment.

#Tool Compatibility
EDA Playground's support for multiple HDLs ensures compatibility with the project's choice of hardware description language, accommodating the design specifications and preferences.

#Simulation Verification
The platform aids in the verification of the RISC-V processor core's simulation results, allowing designers to assess the correctness and efficiency of their implementations.

#Conclusion: 
EDA Playground's cloud-based approach, collaborative features, and support for various HDLs make it a valuable asset in the project's RISC-V processor core development. The platform's accessibility and integration with diverse EDA tools contribute to an efficient and collaborative design and simulation process. As the project progresses, EDA Playground continues to serve as a versatile and user-friendly environment for exploring, testing, and refining the 32-bit processor core implementation.

#Specifications of the 32-Bit RISC-V Processor Core:  

#Instruction Set Architecture (ISA)
   - The processor core is based on the RISC-V ISA, specifically adhering to the RISC-V 32I base instruction set.
   - It encompasses the initial 37 instructions defined in the base ISA, providing a foundational set for computational tasks.

#Register File
   - The core features a register file with 32 general-purpose registers, each having a width of 32 bits.
   - The registers serve as key components for storing and manipulating data during program execution.

#Processor Architecture
   - The processor core is designed using Verilog, a hardware description language, ensuring a comprehensive and synthesizable representation of the hardware logic.

#Assembler
   - Customasm, an open-source and customizable assembler, is employed for translating human-readable assembly code into machine code compatible with the processor core.
   - Customasm allows for flexibility in defining and customizing the instruction set architecture (ISA), aligning with the specific subset of instructions chosen for the project.

#Simulation Tools
   - EDA Playground, an online platform for Electronic Design Automation (EDA), is utilized for simulation purposes.
   - iVerilog, a Verilog simulator, is employed to simulate and validate the functionality of the processor core design.

#Logic Designer and Simulator
   - Digital, an open-source logic designer and simulator, contributes to the overall design and testing process.
   - It enables visualization, analysis, and synthesis of combinatorial and sequential circuits, offering a comprehensive environment for digital logic design.

#Memory Architecture
   - The processor core features separate 32-bit addressable memory spaces for program and data, enhancing modularity and specialization.
   - Dedicated buses for program and data memory ensure efficient data transfer.

#Execution Model
   - The processor core operates in a non-pipelined architecture, allowing for a single instruction per cycle.
   - An individual Arithmetic Logic Unit (ALU) is designated for Branch instructions, optimizing branch execution.

#Instruction Decoding
   - The instruction decoding process involves identifying the instruction type based on the opcode (first 7 bits).
   - Specialized instruction decoders are employed to interpret and execute specific types of instructions, ensuring efficient processing.

#Exception Handling
    - The core lacks interrupt handling, relying on a default state within each unit to handle exceptions.
    - Exception triggers result in a default state, simplifying the exception handling mechanism.

#Testing Strategy
    - Separate testbenches are implemented for each unit of the processor, ensuring individual component testing.
    - An overall testbench facilitates comprehensive simulation and testing of the entire processor core.
    - The testing is conducted using the Digital logic designer and simulator, a reliable open-source tool.

#Clock Frequency
    - As the project proceeds only up to simulation, no specific clock frequency is defined.

#Collaborative Development Tools
    - The project benefits from collaborative and online development tools such as EDA Playground, enabling team members to work collaboratively on the design and simulation.

#Educational Focus
    - The design choices and specifications are geared towards educational purposes, providing a simplified yet comprehensive introduction to processor architecture and digital logic design.

#Customization and Extensibility
    - The use of Customasm for assembling and Digital for logic design ensures customization and extensibility in the project.
    - The modular and plugin-based nature of Customasm allows for easy adaptation to changes or additions in the instruction set.

These specifications collectively define the architecture, tools, and methodologies employed in the development of the 32-bit RISC-V processor core. The project's focus on simplicity, modularity, and educational value guides the design choices and implementation strategies.
