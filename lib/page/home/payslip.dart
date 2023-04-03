import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaySlip extends StatefulWidget {
  const PaySlip({Key? key}) : super(key: key);

  @override
  State<PaySlip> createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1037),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'PaySlip',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        child: ListView(
          children: [
            payslip(
                basicsalary: "100000",
                bonus: "20000",
                overtime: "50000",
                absent: "10000",
                tax: "1000",
                otherE: "30300",
                otherD: "127993",
                bpjs: "1000",
                date: DateFormat.yMMMEd().format(DateTime.now())),
            payslip(
                basicsalary: "100000",
                bonus: "20000",
                overtime: "50000",
                absent: "10000",
                tax: "1000",
                bpjs: "1000",
                otherE: "30300",
                otherD: "127993",
                date: DateFormat.yMMMEd().format(DateTime.now())),
          ],
        ),
      ),
    );
  }

  Widget payslip(
      {String? basicsalary,
      String? bonus,
      String? overtime,
      String? absent,
      String? tax,
      String? bpjs,
      String? date,
      String? otherE,
      String? otherD}) {
    final oCcy = NumberFormat("#,##0", "en_US");
    String basicsalaryformat = oCcy.format(double.parse(basicsalary!));
    String bonusformat = oCcy.format(double.parse(bonus!));
    String overtimeformat = oCcy.format(double.parse(overtime!));
    String taxformat = oCcy.format(double.parse(tax!));
    String absentformat = oCcy.format(double.parse(absent!));
    String bpjsformat = oCcy.format(double.parse(bpjs!));
    String otherearnings = oCcy.format(double.parse(otherE!));
    String otherdeductions = oCcy.format(double.parse(otherD!));

    // logic untuk menjumlahkan
    double totalearnings = (double.parse(basicsalary)) +
        (double.parse(bonus)) +
        (double.parse(overtime)) +
        (double.parse(otherE));

    double totaldeductions = (double.parse(absent)) +
        (double.parse(tax)) +
        (double.parse(bpjs)) +
        (double.parse(otherD));

    double totalsalary = totalearnings - totaldeductions;

    String totalearningsformat = oCcy.format(totalearnings);
    String totaldeductionsformat = oCcy.format(totaldeductions);
    String totalsalaryformat = oCcy.format(totalsalary);

    //build
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Date $date"),
                  ],
                ),
                // judul
                const Text(
                  "Earnings",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                //basic salary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Basic Salary",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $basicsalaryformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 20),
                //bonus
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bonus",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $bonusformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 15),
                // overtime
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Overtime",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $overtimeformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 15),
                // overtime
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $otherearnings",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const Divider(),
                // total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Earnings",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $totalearningsformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                // judul
                const Text(
                  "Deductions",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                //basic salary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Absent",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $absentformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 20),
                //bonus
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax", style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $taxformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 15),
                // overtime
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("BPJS", style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $bpjsformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const SizedBox(height: 15),
                // other
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $otherdeductions",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const Divider(),
                // total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Deductions",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Text("Rp. $totaldeductionsformat",
                        style: TextStyle(color: Colors.grey.shade800))
                  ],
                ),
                const Divider(),
                const SizedBox(height: 15),

                //total gaji
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Net Pay",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp. $totalsalaryformat",
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade200),
                        child: const Text("Download PDF",
                            style: TextStyle(
                              color: Colors.black,
                            )))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
