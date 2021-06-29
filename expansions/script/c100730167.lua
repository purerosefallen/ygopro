--高速决斗技能-香水战术
Duel.LoadScript("speed_duel_common.lua")
function c100730167.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730167.skill,c100730167.con,aux.Stringid(100730167,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730167.filter(c)
	return c:GetFlagEffect(100730167)==0 and c:GetFlagEffectLabel(100730167)~=c:GetFieldID() and c:IsFacedown()
end

function c100730167.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.IsExistingMatchingCard(c100730167.filter,tp,LOCATION_DECK,0,1,nil)
end

function c100730167.reg(c)
	c:RegisterFlagEffect(100730167,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end

function c100730167.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730167)
	local g=Duel.GetDecktopGroup(tp,1)
	if not g or g:GetCount()==0 then return end
	g:ForEach(c100730167.reg)
	Duel.ConfirmCards(tp,g)
end
function c100730167.adjustop(e,tp)
	local g=Duel.GetDecktopGroup(tp,1)
	if not g or g:GetCount()==0 then return end
	local fc=g:GetFirst()
	if fc:IsPosition(POS_FACEUP_DEFENSE) then return end
	fc:ReverseInDeck()
end