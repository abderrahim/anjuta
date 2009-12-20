/**
 * SECTION:ianjuta-language-support
 * @title: IAnjutaLanguageSupport
 * @short_description: Programming language specific supports from plugins
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.LanguageSupport : Object
{
    public abstract List<string> get_supported_languages () throws Error;
    public abstract bool supports(string language) throws Error;
}
