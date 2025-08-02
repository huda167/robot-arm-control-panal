import 'package:flutter/material.dart';

void main() => runApp(const RobotArmApp());

class RobotArmApp extends StatelessWidget {
  const RobotArmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Arm Control Panel',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const ControlPanel(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  List<double> motorValues = List.generate(4, (index) => 0);
  List<Map<String, dynamic>> savedPoses = [];

  void savePose() {
    setState(() {
      savedPoses.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'motors': List.from(motorValues)
      });
    });
  }

  void loadPose(int index) {
    setState(() {
      motorValues = List.from(savedPoses[index]['motors']);
    });
  }

  void removePose(int index) {
    setState(() {
      savedPoses.removeAt(index);
    });
  }

  void resetMotors() {
    setState(() {
      motorValues = List.filled(4, 0);
    });
  }

  void runPose() {
    // Placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Running current pose...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Robot Arm Control Panel'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            for (int i = 0; i < motorValues.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Motor ${i + 1}: ${motorValues[i].toInt()}'),
                  Slider(
                    min: 0,
                    max: 180,
                    value: motorValues[i],
                    onChanged: (value) {
                      setState(() {
                        motorValues[i] = value;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: resetMotors, child: const Text('Reset')),
                ElevatedButton(onPressed: savePose, child: const Text('Save Pose')),
                ElevatedButton(onPressed: runPose, child: const Text('Run')),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Saved Poses:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...savedPoses.asMap().entries.map(
              (entry) {
                int index = entry.key;
                List motors = entry.value['motors'];
                return Card(
                  child: ListTile(
                    title: Text('Pose ${index + 1}: ${motors.map((e) => e.toInt()).join(', ')}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => loadPose(index), icon: const Icon(Icons.refresh)),
                        IconButton(onPressed: () => removePose(index), icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}