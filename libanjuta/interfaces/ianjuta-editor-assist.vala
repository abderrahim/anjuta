/**
 * SECTION:ianjuta-editor-assist
 * @title: IAnjutaEditorAssist
 * @short_description: Text editor assist interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/ianjuta-editor-assist
 *
 */
public struct IAnjuta.EditorAssistProposal
{
	string label;
	string? markup;
	string? info;
	string? text;
	Gdk.Pixbuf? icon;
	void* data;
}

public interface IAnjuta.EditorAssist : Editor
{
	/*
	 * ianjuta_editor_assist_add
	 * @self: self
	 * @provider: a IAnjutaProvider
	 * @error: Error handling
	 *
	 * Add a provider to the list of completion providers
	 */
	public abstract void add(Provider provider) throws Error;

	/*
	 * ianjuta_editor_assist_remove
	 * @self: self
	 * @provider: a IAnjutaProvider
	 * @error: Error handling
	 *
	 * Remove a provider from the list of completion providers
	 */
	public abstract void remove(Provider provider) throws Error;

	/*
	 * ianjuta_editor_assist_invoke
	 * @self: self
	 * @provider: a IAnjutaProvider (can be NULL to use all providers)
	 * @error: Error handling
	 *
	 * Force invokation of a provider at the current cursor position.
     * That means that ianjuta_provider_populate() will be called on the
	 * provider.
	 */
	public abstract void invoke(Provider? provider) throws Error;

	/*
	 * ianjuta_editor_assist_proposals
	 * @self: self
	 * @provider: a IAnjutaProvider
	 * @proposals: a list of IAnjutaProposals
	 * @finished: whether is was the last call in an async operation
	 * @error: Error handling
	 *
	 * Add the list of proposals for the current population. You can add
	 * proposals async as long as the last call sets finished to TRUE. That
	 * is usually called by the IAnjutaProvider after it was triggered by
	 * ianjuta_provider_populate()
	 *
	 */
	public abstract void proposals(Provider provider, List<EditorAssistProposal?> proposals, bool finished) throws Error;
}
