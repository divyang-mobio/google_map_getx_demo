import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_map_getx_demo/view_model/location_controller.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () =>
                // Get.back(),
                Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Saved Data'),
      ),
      body: GetBuilder<LocationController>(
        // Obx(()
        // GetX<DataFetch>(
        init: Get.find<LocationController>(),
        builder: (controller) => (controller.data.isNotEmpty)
            ? ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onDoubleTap: () =>
                    //     controller.delete(controller.data[index].id as int),
                    child: Card( 
                      elevation: 8,
                      child: ListTile(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("id: ${controller.data[index].id}"),
                              const SizedBox(height: 10),
                              Text(
                                "longitude: ${controller.data[index].longitude.toString()}",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "latitude: ${controller.data[index].latitude.toString()}",
                              )
                            ]),
                      ),
                    ),
                  );
                })
            : const Center(child: Text("no Data")),
      ),
    );
  }
}
