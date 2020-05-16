/**
 * Created by abhishek on 20/3/18.
 * class to generate xml file from string
 */

public with sharing class StringToXml {

    public String returnString{set;get;}
    public String fName= 'abhi';
    public String mName ='kumar';
    public String lName  ='sharma';
    public Long mob =8998;
    public Integer age  =20;

    public void generateXML()
    {
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument(null, '1.0');
        w.writeStartElement('', 'Contacts', 'http://www.example.com');

        w.writeStartElement(null, 'ConInfo', null);
        w.writeAttribute(null, null, 'fName', fName);
        w.writeAttribute(null, null, 'mName', mName);
        w.writeAttribute(null, null, 'lName', lName);
        w.writeAttribute(null, null, 'mob',String.valueOf(mob));
        w.writeAttribute(null, null, 'age', String.valueOf(age));
        w.writeCharacters('One contact Information');
        w.writeEndElement(); //end book

        w.writeEndElement(); //end library
        w.writeEndDocument();
        String xmlOutput = w.getXmlString();
        w.close();
        System.debug('xml ----------> ' +xmlOutput);
        returnString = xmlOutput;
    }

}