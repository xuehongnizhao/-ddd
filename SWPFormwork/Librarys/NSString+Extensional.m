//
//  NSString+Extensional.m
//  iOSProject
//
//  Created by wei.zhang on 16/4/22.
//  Copyright © 2016年 Gigabud. All rights reserved.
//

#import "NSString+Extensional.h"
#import "pinyin.h"
@implementation NSString (Extensional)


#pragma mark - 明确列出转换平台翻译错误的多音字姓氏，并列出正确匹配项
/**
 *  所有的多音字匹配的拼音键值对，每个姓氏多音字对应一个数组，数组中第一个字为正确发音，第二个为错误发音，错误发音用来做字符串替换使用
 *  多音字姓氏使用系统默认转换时，如果转换错误，将使用该键值对匹配替换
 */
+ (NSDictionary*)getDicForAllPolyphoneSurnamePinYin;
{
    static NSDictionary* g_pAllPolyphoneSurnamePinYin = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^
                  {
                      g_pAllPolyphoneSurnamePinYin = [NSMutableDictionary dictionaryWithObjectsAndKeys
                                                      :@[@"po",@"fan"],@"繁"
                                                      ,@[@"ou",@"qu"],@"区"
                                                      ,@[@"qiu",@"chou"],@"仇"
                                                      ,@[@"chong",@"zhong"],@"种"
                                                      ,@[@"shan",@"dan"],@"单"
                                                      ,@[@"xie",@"jie"],@"解"
                                                      ,@[@"zha",@"cha"],@"查"
                                                      ,@[@"zeng",@"ceng"],@"曾"
                                                      ,@[@"bi",@"mi"],@"秘"
                                                      ,@[@"yue",@"le"],@"乐"
                                                      ,@[@"chong",@"zhong"],@"重"
                                                      ,@[@"piao",@"pu"],@"朴"
                                                      ,@[@"miao",@"mou"],@"缪"
                                                      ,@[@"zhai",@"di"],@"翟"
                                                      ,@[@"she",@"zhe"],@"折"
                                                      ,@[@"he",@"hei"],@"黑"
                                                      ,@[@"ge",@"gai"],@"盖"
                                                      ,@[@"shen",@"chen"],@"沈"
                                                      ,@[@"yu chi",@"wei chi"],@"尉迟"
                                                      ,@[@"mo qi",@"wan qi"],@"万俟"
                                                      ,nil];
                  });
    return g_pAllPolyphoneSurnamePinYin;
}

/**
 *  所有多音字匹配的带音调拼音键值对，每个姓氏多音字对应一个数组，数组中第一个字为正确发音，第二个为错误发音，错误发音用来做字符串替换使用
 *  多音字姓氏使用系统默认转换时，如果转换错误，将使用该键值对匹配替换
 */
+ (NSDictionary*)getDicForAllPolyphoneSurnamePinYinWithYinDiao;
{
    static NSDictionary* g_pAllPolyphoneSurnamePinYinWithYinDiao = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^
                  {
                      g_pAllPolyphoneSurnamePinYinWithYinDiao = [NSMutableDictionary dictionaryWithObjectsAndKeys
                                                                 :@[@"pó",@"fán"],@"繁"
                                                                 ,@[@"ōu",@"qū"],@"区"
                                                                 ,@[@"qiú",@"chóu"],@"仇"
                                                                 ,@[@"chóng",@"zhǒng"],@"种"
                                                                 ,@[@"shàn",@"dān"],@"单"
                                                                 ,@[@"xiè",@"jiě"],@"解"
                                                                 ,@[@"zhā",@"chá"],@"查"
                                                                 ,@[@"zēng",@"céng"],@"曾"
                                                                 ,@[@"bì",@"mì"],@"秘"
                                                                 ,@[@"yuè",@"lè"],@"乐"
                                                                 ,@[@"chóng",@"zhòng"],@"重"
                                                                 ,@[@"piáo",@"pǔ"],@"朴"
                                                                 ,@[@"miào",@"móu"],@"缪"
                                                                 ,@[@"xiǎn",@"shěng"],@"冼"
                                                                 ,@[@"zhái",@"dí"],@"翟"
                                                                 ,@[@"shé",@"zhé"],@"折"
                                                                 ,@[@"hè",@"hēi"],@"黑"
                                                                 ,@[@"gě",@"gài"],@"盖"
                                                                 ,@[@"shěn",@"chén"],@"沈"
                                                                 ,@[@"yù chí",@"wèi chí"],@"尉迟"
                                                                 ,@[@"mò qí",@"wàn qí"],@"万俟"
                                                                 ,nil];
                  });
    return g_pAllPolyphoneSurnamePinYinWithYinDiao;
}

/**
 *  所有的多音字匹配的拼音首字母键值对，每个姓氏多音字对应一字符串
 *  多音字姓氏使用第三方平台转换时，如果转换错误，将使用该键值对匹配替换
 */
+ (NSDictionary*)getDicForAllPolyphoneSurnameFirstLetters;
{
    static NSDictionary* g_pAllPolyphoneSurnameFirstLetters = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^
                  {
                      g_pAllPolyphoneSurnameFirstLetters = [NSMutableDictionary dictionaryWithObjectsAndKeys
                                                            :@"p",@"繁"
                                                            ,@"o",@"区"
                                                            ,@"q",@"仇"
                                                            ,@"c",@"种"
                                                            ,@"s",@"单"
                                                            ,@"x",@"解"
                                                            ,@"z",@"查"
                                                            ,@"z",@"曾"
                                                            ,@"b",@"秘"
                                                            ,@"y",@"乐"
                                                            ,@"c",@"重"
                                                            ,@"x",@"冼"
                                                            ,@"z",@"翟"
                                                            ,@"s",@"折"
                                                            ,@"s",@"沈"
                                                            ,@"yc",@"尉迟"
                                                            ,@"mq",@"万俟"
                                                            ,nil];
                  });
    return g_pAllPolyphoneSurnameFirstLetters;
}

/**
 *  把字符串中的汉字转换成拼音
 *
 *  @param isForSurname 明确字符串是否表示姓名
 *  @param bFlag        明确字符串转换完毕后是否需要拼音音调
 *
 *  @return 返回结果不做特殊处理，请注意系统默认转换汉字时采用小写拼音
 */
- (NSString*)pinyinForSort:(BOOL)isForSurname withYindiao:(BOOL)bFlag;
{
    NSString* convertString = self;
    if (isForSurname)
    {
        //如果是姓名优先去掉“·”符号
        convertString = [self stringByReplacingOccurrencesOfString:@"·" withString:@""];
    }
    NSMutableString *mutableString = [NSMutableString stringWithString:convertString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    if (bFlag)
    {
        NSString* pinyinString = [NSString stringWithString:mutableString];
        NSMutableString* resultString = [NSMutableString stringWithString:pinyinString];
        
        if (isForSurname)
        {
            //处理姓氏多音字
            NSArray* allPolyphoneSurname = [[NSString getDicForAllPolyphoneSurnamePinYinWithYinDiao] allKeys];
            for (NSString* tempPolyphoneSurname in allPolyphoneSurname)
            {
                if ([convertString hasPrefix:tempPolyphoneSurname])
                {
                    NSArray* arrayOfPolyphoneSurnamePinYinWithYinDiao = [[NSString getDicForAllPolyphoneSurnamePinYinWithYinDiao] valueForKey:tempPolyphoneSurname];
                    NSString* rightPinYin = [arrayOfPolyphoneSurnamePinYinWithYinDiao objectAtIndex:0];
                    NSString* wrongPinYin = [arrayOfPolyphoneSurnamePinYinWithYinDiao objectAtIndex:1];
                    NSRange rangeOfPinYin = NSMakeRange(0, wrongPinYin.length);
                    if ([[resultString substringWithRange:rangeOfPinYin] isEqualToString:wrongPinYin])
                    {
                        [resultString replaceCharactersInRange:rangeOfPinYin withString:rightPinYin];
                    }
                    break;
                }
            }
        }
        return resultString;
    }
    else
    {
        NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        NSMutableString* resultString = [NSMutableString stringWithString:pinyinString];
        
        if (isForSurname)
        {
            //处理姓氏多音字
            NSArray* allPolyphoneSurname = [[NSString getDicForAllPolyphoneSurnamePinYin] allKeys];
            for (NSString* tempPolyphoneSurname in allPolyphoneSurname)
            {
                if ([convertString hasPrefix:tempPolyphoneSurname])
                {
                    NSArray* arrayOfPolyphoneSurnamePinYin = [[NSString getDicForAllPolyphoneSurnamePinYin] valueForKey:tempPolyphoneSurname];
                    NSString* rightPinYin = [arrayOfPolyphoneSurnamePinYin objectAtIndex:0];
                    NSString* wrongPinYin = [arrayOfPolyphoneSurnamePinYin objectAtIndex:1];
                    NSRange rangeOfPinYin = NSMakeRange(0, wrongPinYin.length);
                    if ([[resultString substringWithRange:rangeOfPinYin] isEqualToString:wrongPinYin])
                    {
                        [resultString replaceCharactersInRange:rangeOfPinYin withString:rightPinYin];
                    }
                    break;
                }
            }
        }
        return resultString;
    }
}

#pragma mark - PublicFunctions
- (NSString*)firstLettersForSort:(BOOL)isForSurname;
{
    NSString* convertString = self;
    if (isForSurname)
    {
        //如果是姓名优先去掉“·”符号
        convertString = [self stringByReplacingOccurrencesOfString:@"·" withString:@""];
    }
    NSMutableString* resultString = [NSMutableString string];
    if (convertString.length > 0)
    {
        unichar indexChar;
        for (NSUInteger nIndex = 0; nIndex < convertString.length; ++nIndex)
        {
            indexChar = [convertString characterAtIndex:nIndex];
            //判断字符是否为英文字母
            if ((indexChar >= 'A' && indexChar <= 'Z') ||
                (indexChar >= 'a' && indexChar <= 'z'))
            {
                [resultString appendString:[NSString stringWithFormat:@"%c", indexChar]];
            }
            //判断字符是否为汉字
            else if (isFirstLetterHANZI(indexChar))
            {
                NSString* firstCharacterInPinYin = [NSString stringWithFormat:@"%c",pinyinFirstLetter(indexChar)];//从第三方库中匹配这个汉子的拼音首字母
                if (firstCharacterInPinYin)
                {
                    [resultString appendString:firstCharacterInPinYin];
                }
                else//未识别字符保持不变
                {
                    [resultString appendString:[convertString substringWithRange:NSMakeRange(nIndex, 1)]];
                }
            }
            //其他字符保持不变
            else
            {
                [resultString appendString:[convertString substringWithRange:NSMakeRange(nIndex, 1)]];
            }
        }
        if (isForSurname)
        {
            //处理姓氏多音字
            NSArray* allPolyphoneSurname = [[NSString getDicForAllPolyphoneSurnameFirstLetters] allKeys];
            for (NSString* tempPolyphoneSurname in allPolyphoneSurname)
            {
                if ([convertString hasPrefix:tempPolyphoneSurname])
                {
                    [resultString replaceCharactersInRange:NSMakeRange(0, tempPolyphoneSurname.length) withString:[[NSString getDicForAllPolyphoneSurnameFirstLetters] valueForKey:tempPolyphoneSurname]];
                    break;
                }
            }
        }
    }
    return resultString;
}

- (NSString*)pinyinForSort:(BOOL)isForSurname;
{
    return [self pinyinForSort:isForSurname withYindiao:NO];
}

- (NSString*)pinyinWithToneForSort:(BOOL)isForSurname;
{
    return [self pinyinForSort:isForSurname withYindiao:YES];
}

@end
