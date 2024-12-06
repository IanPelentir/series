import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'serie.dart';

class PdfGenerator {
  static Future<void> generatePdf(List<Serie> series) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Relatório de Séries', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              context: context,
              data: <List<String>>[
                <String>['Nome', 'Gênero', 'Descrição', 'Pontuação', 'Vitórias'],
                ...series.map((serie) => [serie.nome, serie.genero, serie.descricao, serie.pontuacao.toString(), serie.vitorias.toString()]),
              ],
            ),
          ],
        ),
      ),
    );

    // Utilize a funcionalidade de impressão e visualização de PDFs
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
