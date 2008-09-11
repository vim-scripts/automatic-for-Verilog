Automatic Instance
The instance file should be indicated first by the following comment line:
// Instance:	<file_path>
The file name should be the same with the module name, and the each file containts only one module.
The nets connect with sub-module in the top module named by its corresponding name in sub-module, you can change them after autoinst.
If the width of port is indicated by a parameter in the sub-module, it will not be displaced by a new parameter or constant in the top module.