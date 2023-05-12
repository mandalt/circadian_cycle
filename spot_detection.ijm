//detecting FISH spots

dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
//setBatchMode(true);


for (i = 0; i< list.length; i++){
	showProgress(i+1, list.length);
	run("Bio-Formats Importer", "open=" + dir1 + list[i] +" color_mode=Default rois_import=[ROI manager]");
//	open(dir1+list[i]);
	getDimensions(width, height, channels, slices, frames);
	run("Z Project...", "start=1 stop=11 projection=[Max Intensity]");
	close(list[i]); //close z stack images
	if (channels > 1){ run("Split Channels");
		channel_num = nImages ;
		}
	//j is the counter for the channels
	//count FISH spots in each channel and export the results as csv
	for (j = 1; j <= (channel_num); j++){
//		thresH = newArray("0.0150","0.0103","0");
        thresH = newArray("0.0202","0.0109", "0.0125","0");
		closeIng = newArray("C1*","C2*","C3*");
//		closeIng = newArray("C1*");
//		selectImage(j);
//		currentImage_name = getTitle();
//		print(j, currentImage_name);
		x = thresH[j-1];
		if (j < (channel_num)) {
				selectImage(1);
				currentImage_name = getTitle();
//				print(j, currentImage_name);
		    	run("RS-FISH", "image=currentImage_name mode=Advanced anisotropy=1.0000 robust_fitting=[No RANSAC] compute_min/max use_anisotropy add sigma=1.50000 threshold=x support=3 min_inlier_ratio=0.10 max_error=1.50 spot_intensity_threshold=1030.79 background=[No background subtraction] background_subtraction_max_error=0.05 background_subtraction_min_inlier_ratio=0.10 results_file=[] num_threads=8 block_size_x=128 block_size_y=128 block_size_z=16");
				n_spots = roiManager("count");
				roiManager("select", newArray(n_spots));
				roiManager("Add");
				roiManager("Show All without labels");
				run("Flatten");
				saveAs("TIFF", dir2 + currentImage_name);
				roiManager("delete");
				close(closeIng[j-1]);
			}else if (j  == (channel_num)){
//				selectImage(j);
		        currentImage_name = getTitle();
				saveAs("TIFF", dir2 + "CMB" + currentImage_name);
				close("*");
			
//		}else if (j == 2) {
//				print(j, currentImage_name);
//				run("RS-FISH", "image=currentImage_name mode=Advanced anisotropy=1.0000 robust_fitting=[No RANSAC] compute_min/max use_anisotropy add sigma=1.50000 threshold=0.0103 support=3 min_inlier_ratio=0.10 max_error=1.50 spot_intensity_threshold=1030.79 background=[No background subtraction] background_subtraction_max_error=0.05 background_subtraction_min_inlier_ratio=0.10 results_file=[] num_threads=8 block_size_x=128 block_size_y=128 block_size_z=16");
//				n_spots = roiManager("count");
//				roiManager("select", newArray(n_spots));
//				roiManager("Add");
////				run("Properties...", "stroke=red point=Dot size=[Large]");
////				roiManager("Show All without labels");
////	//			roiManager("Set Point Type", "circle");
////	//	        roiManager("Set Color", "red");
//				run("Flatten");
//				saveAs("TIFF", dir2 + currentImage_name);
//				roiManager("delete");
//				close("C1*");
			}
		}
//	roiManager("delete");
	run("Close All");
}

//run("Close")

