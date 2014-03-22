#include "utils.h"

#include <postfix.h>
#include <cvtFast.h>

#include <QVector>
#include <QVariant>
#include <QProcess>
#include <QtDebug>

#define M_PI 3.14159265358979323846

// conversion functions from conversion.c
extern "C" {
extern int localCvtLongToHexString(long source, char *pdest);
extern void localCvtDoubleToString(double flt_value, char  *pstr_value, unsigned short precision);
extern void localCvtDoubleToExpNotationString(double value, char *textField, unsigned short precision);
extern void medmLocalCvtDoubleToSexaStr (double value,  char *string, unsigned short prec,
                                 double hopr, double lopr, int *status);
}

Utils::Utils(QObject *parent) :
    QObject(parent)
{
}

QString Utils::format(QString format, double number)
{
    return QString("").sprintf(format.toLatin1(), number);
}

double Utils::calculate(QString expr, QVariantList input)
{
    double result = 0.0;
    short error;
    char infix[INFIX_TO_POSTFIX_SIZE(80)];
    
    QVector<double> d;
    foreach(QVariant v, input)
        d.push_back(v.toDouble());
    
    postfix(expr.toLatin1().constData(), infix, &error);
    
    calcPerform(d.data(), &result, infix);

    return result;
}

bool Utils::execute(QString program)
{
    return QProcess::startDetached(program);
}

QString Utils::convert(int format, QVariant value, int precision)
{
    char textField[128];
    int status;

    switch (format) {
    case TextFormat::String:
    case TextFormat::Decimal:
        cvtDoubleToString(value.toDouble(), textField, precision);
        break;
    case TextFormat::Exponential:
        cvtDoubleToExpString(value.toDouble(), textField, precision);
        break;
    case TextFormat::EngNotation:
        localCvtDoubleToExpNotationString(value.toDouble(), textField, precision);
        break;
    case TextFormat::Compact:
        cvtDoubleToCompactString(value.toDouble(), textField, precision);
        break;
    case TextFormat::Truncated:
        cvtLongToString(value.toInt(), textField);
        break;
    case TextFormat::Hexadecimal:
        localCvtLongToHexString(value.toInt(), textField);
        break;
    case TextFormat::Octal:
        cvtLongToOctalString(value.toInt(), textField);
        break;
    case TextFormat::Sexagesiaml:
        medmLocalCvtDoubleToSexaStr(value.toDouble(), textField, precision,
          0.0, 0.0, &status);
        break;
    case TextFormat::SexagesimalHMS:
        medmLocalCvtDoubleToSexaStr(value.toDouble()*12.0/M_PI, textField, precision,
          0.0,0.0,&status);
        break;
    case TextFormat::SexagesimalDMS:
        medmLocalCvtDoubleToSexaStr(value.toDouble()*180.0/M_PI, textField, precision,
          0.0,0.0,&status);
        break;
    default:
        break;
    }
    return QString::fromLatin1(textField);
}
