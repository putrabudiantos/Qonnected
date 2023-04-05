import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaySlip extends StatefulWidget {
  final String? basicsalary;
  final String? bonus;
  final String? overtime;
  final String? absent;
  final String? tax;
  final String? bpjs;
  final String? date;
  final String? otherE;
  final String? viewproject;
  final String? dailyallowance;
  final String? healthbenefit;
  final String? extra;
  final String? lates;
  final String? wfh;
  final String? pinalty;
  final String? otherD;
  const PaySlip(
      {Key? key,
      this.basicsalary,
      this.bonus,
      this.overtime,
      this.absent,
      this.tax,
      this.bpjs,
      this.date,
      this.otherE,
      this.viewproject,
      this.dailyallowance,
      this.healthbenefit,
      this.extra,
      this.lates,
      this.wfh,
      this.pinalty,
      this.otherD})
      : super(key: key);

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
              absent: "12048",
              basicsalary: "43827",
              bonus: "32791",
              bpjs: "43792",
              dailyallowance: "29743",
              date: "173945",
              extra: "2745",
              healthbenefit: "164782",
              lates: "329583",
              otherD: "208214",
              otherE: "459273",
              overtime: "23853",
              pinalty: "297482",
              tax: "4583",
              viewproject: "243802",
              wfh: "23432",
            )
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
      String? viewproject,
      String? dailyallowance,
      String? healthbenefit,
      String? extra,
      String? lates,
      String? wfh,
      String? totalearningss,
      String? totaldeductionss,
      String? totalpayments,
      String? pinalty,
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
    String viewprojectformat = oCcy.format(double.parse(viewproject!));
    String latesformat = oCcy.format(double.parse(lates!));
    String wfhformat = oCcy.format(double.parse(wfh!));
    String pinaltyformat = oCcy.format(double.parse(pinalty!));
    String extraformat = oCcy.format(double.parse(extra!));
    String healthbenefitformat = oCcy.format(double.parse(healthbenefit!));
    String dailyallowanceformat = oCcy.format(double.parse(dailyallowance!));

    // logic untuk menjumlahkan
    double totalearnings = (double.parse(basicsalary)) +
        (double.parse(bonus)) +
        (double.parse(overtime)) +
        (double.parse(viewproject)) +
        (double.parse(dailyallowance)) +
        (double.parse(extra)) +
        (double.parse(healthbenefit)) +
        (double.parse(otherE));

    double totaldeductions = (double.parse(absent)) +
        (double.parse(tax)) +
        (double.parse(bpjs)) +
        (double.parse(lates)) +
        (double.parse(pinalty)) +
        (double.parse(wfh)) +
        (double.parse(otherD));

    double totalsalary = totalearnings - totaldeductions;

    totalearningss = oCcy.format(totalearnings);
    totaldeductionss = oCcy.format(totaldeductions);
    totalpayments = oCcy.format(totalsalary);

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
                    basicsalary.isNotEmpty
                        ? Text("Rp. $basicsalaryformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 20),
                //bonus
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bonus",
                        style: TextStyle(color: Colors.grey.shade800)),
                    bonus.isNotEmpty
                        ? Text("Rp. $bonusformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // overtime
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Overtime",
                        style: TextStyle(color: Colors.grey.shade800)),
                    overtime.isNotEmpty
                        ? Text("Rp. $overtimeformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // Viewproject
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("View Project",
                        style: TextStyle(color: Colors.grey.shade800)),
                    viewproject.isNotEmpty
                        ? Text("Rp. $viewprojectformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // Daily Allowance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Daily Allowance",
                        style: TextStyle(color: Colors.grey.shade800)),
                    dailyallowance.isNotEmpty
                        ? Text("Rp. $dailyallowanceformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // Extra
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Extra",
                        style: TextStyle(color: Colors.grey.shade800)),
                    extra.isNotEmpty
                        ? Text("Rp. $extraformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),

                // Health benefit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Health Benefit",
                        style: TextStyle(color: Colors.grey.shade800)),
                    healthbenefit.isNotEmpty
                        ? Text("Rp. $healthbenefitformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // Other
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other",
                        style: TextStyle(color: Colors.grey.shade800)),
                    otherE.isNotEmpty
                        ? Text("Rp. $otherearnings",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const Divider(),

                // total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Earnings",
                        style: TextStyle(color: Colors.grey.shade800)),
                    totalearningss.isNotEmpty
                        ? Text("Rp. $totalearningss",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
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
                //absent
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Absent",
                        style: TextStyle(color: Colors.grey.shade800)),
                    absent.isNotEmpty
                        ? Text("Rp. $absentformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 20),
                // tax
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax", style: TextStyle(color: Colors.grey.shade800)),
                    tax.isNotEmpty
                        ? Text("Rp. $taxformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),
                // bpjs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("BPJS", style: TextStyle(color: Colors.grey.shade800)),
                    bpjs.isNotEmpty
                        ? Text("Rp. $bpjsformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),

                // late
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Late", style: TextStyle(color: Colors.grey.shade800)),
                    lates.isNotEmpty
                        ? Text("Rp. $latesformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),

                // pinalty
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pinalty",
                        style: TextStyle(color: Colors.grey.shade800)),
                    pinalty.isNotEmpty
                        ? Text("Rp. $pinaltyformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
                  ],
                ),
                const SizedBox(height: 15),

                // WFH
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("WFH", style: TextStyle(color: Colors.grey.shade800)),
                    wfh.isNotEmpty
                        ? Text("Rp. $wfhformat",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("Rp. 0")
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
                    otherdeductions.isNotEmpty
                        ? Text("Rp. $totaldeductionss",
                            style: TextStyle(color: Colors.grey.shade800))
                        : const Text("0")
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
                    totalpayments.isNotEmpty
                        ? Text(
                            "Rp. $totalpayments",
                            style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        : const Text("Rp. 0")
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
