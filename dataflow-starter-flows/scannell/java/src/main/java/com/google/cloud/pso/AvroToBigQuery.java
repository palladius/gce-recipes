package com.google.cloud.pso;

/**
 * From https://gist.github.com/ankurcha/56f33837c10bed31093a
 *
 * This should be part of the core BigQuery Beam library, or something similar, according
 * to this blog:
 * https://cloud.google.com/blog/big-data/2016/03/improve-bigquery-ingestion-times-10x-by-using-avro-source-format
 *
 * (Avro is being used internally to read data from BigQuery, not sure about writing)
 */

import java.util.ArrayList;
import org.apache.avro.LogicalType;
import org.apache.avro.specific.SpecificRecord;

import com.google.api.client.json.GenericJson;
import com.google.api.services.bigquery.model.TableCell;
import com.google.api.services.bigquery.model.TableFieldSchema;
import com.google.api.services.bigquery.model.TableRow;
import com.google.api.services.bigquery.model.TableSchema;
import org.apache.avro.Schema;

import java.util.List;
import org.apache.beam.sdk.transforms.DoFn;

import static org.apache.avro.Schema.*;

  public class AvroToBigQuery<TRecord extends SpecificRecord>  extends DoFn<TRecord, TableRow> {

    @ProcessElement
    public void processElement(ProcessContext processContext) throws Exception {
      processContext.output(getTableRow(processContext.element()));
    }

    static TableRow getTableRow(SpecificRecord record) {
      TableRow row = new TableRow();
      encode(record, row);
      return row;
    }


    static TableCell getTableCell(SpecificRecord record) {
      TableCell cell = new TableCell();
      encode(record, cell);
      return cell;
    }

    private static void encode(SpecificRecord record, GenericJson row) {
      Schema schema = record.getSchema();
      for (Field field : schema.getFields()) {
        Type type = field.schema().getType();
        switch (type) {
          case RECORD:
            row.set(field.name(), getTableCell((SpecificRecord) record.get(field.pos())));
            break;
          case INT:
          case LONG:
            row.set(field.name(), ((Number)record.get(field.pos())).longValue());
            break;
          case BOOLEAN:
            row.set(field.name(), record.get(field.pos()));
            break;
          case FLOAT:
          case DOUBLE:
            row.set(field.name(), ((Number)record.get(field.pos())).doubleValue());
            break;
          default:
            row.set(field.name(), String.valueOf(record.get(field.pos())));
        }
      }
    }

    public static TableSchema getTableSchemaRecord(Schema schema) {
      return new TableSchema().setFields(getFieldsSchema(schema.getFields()));
    }

    static List<TableFieldSchema> getFieldsSchema(List<Schema.Field> fields) {
      ArrayList<TableFieldSchema> ofields = new ArrayList<TableFieldSchema>();

      for (Field field : fields) {
        TableFieldSchema column = new TableFieldSchema().setName(field.name());
        Type type = field.schema().getType();
        LogicalType t = field.schema().getLogicalType();
        switch (type) {
          case RECORD:
            column.setType("RECORD");
            column.setFields(getFieldsSchema(fields));
            break;
          case INT:
          case LONG:
            if (field.schema().getLogicalType().getName().equals("timestamp-millis")) {
              column.setType("TIMESTAMP");
            } else {
              column.setType("INTEGER");
            }
            break;
          case BOOLEAN:
            column.setType("BOOLEAN");
            break;
          case FLOAT:
          case DOUBLE:
            column.setType("FLOAT");
            break;
          default:
            column.setType("STRING");
        }
        ofields.add(column);
      }

      return ofields;
    }

}
