from scipy.io import loadmat
def get_lowerbound_activation_matrix_data():
	"""
	this example is only for muscle 30, all other muscle activation columns 
	will be set to -1 to indicate they weren't computed.
	"""
	muscle_of_interest = 30
	mat_data_struct = loadmat('../lowerbound_mat_30_a90.mat')
	activation_matrix = mat_data_struct['lowerbound_mat']
	return activation_matrix