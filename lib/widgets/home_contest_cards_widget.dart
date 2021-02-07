import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget homeContestCards(
    {contestImage, contestName, contestPrize, contestEntryFee}) {
  return AspectRatio(
    aspectRatio: 1.75 / 2,
    child: Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(contestImage), fit: BoxFit.fill,)),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.white,
              Colors.green.withOpacity(0.1),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  child: Center(
                      child: Text(
                    "PCH",
                    style: GoogleFonts.oranienbaum(
                        color: Colors.white, fontSize: 12),
                  )),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                ),
                AutoSizeText(
                  "Photo Contest #${contestName.toString()}",
                  maxLines: 1,
                  style: GoogleFonts.oranienbaum(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  "Photo Contest #${contestName.toString()}",
                  maxLines: 1,
                  style: GoogleFonts.oranienbaum(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  "Prize- ${contestPrize}",
                  maxLines: 1,
                  style: GoogleFonts.oranienbaum(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                AutoSizeText(
                  "Entry Fee-${contestEntryFee}/- only",
                  maxLines: 1,
                  style: GoogleFonts.oranienbaum(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
