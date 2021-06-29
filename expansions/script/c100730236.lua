--高速决斗技能-秘密调查
Duel.LoadScript("speed_duel_common.lua")
function c100730236.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(60391791,c)
	aux.SpeedDuelAtMainPhase(c,c100730236.skill,c100730236.con,aux.Stringid(100730236,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730236.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.IsExistingMatchingCard(c100730236.filter,tp,0,LOCATION_MZONE,1,nil)
end

function c100730236.filter(c)
	return c:GetFlagEffect(100730236)==0 and c:GetFlagEffectLabel(100730236)~=c:GetFieldID() and c:IsFacedown()
end

function c100730236.reg(c)
	c:RegisterFlagEffect(100730236,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end

function c100730236.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(c100730236.filter,tp,0,LOCATION_MZONE,nil)
	if not g or g:GetCount()==0 then return end
	g:ForEach(c100730236.reg)
	Duel.ConfirmCards(tp,g)
end