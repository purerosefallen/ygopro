--高速决斗技能-心灵扫描
Duel.LoadScript("speed_duel_common.lua")
function c100730043.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(60391791,c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730043.skill,c100730043.con,aux.Stringid(100730043,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730043.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnCount()>=3 and Duel.GetCurrentChain()==0
		and Duel.IsExistingMatchingCard(c100730043.filter,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.GetLP(tp)>=3000
end

function c100730043.filter(c)
	return c:GetFlagEffect(100730043)==0 and c:GetFlagEffectLabel(100730043)~=c:GetFieldID() and c:IsFacedown()
end

function c100730043.reg(c)
	c:RegisterFlagEffect(100730043,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end

function c100730043.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(c100730043.filter,tp,0,LOCATION_ONFIELD,nil)
	if not g or g:GetCount()==0 then return end
	g:ForEach(c100730043.reg)
	Duel.ConfirmCards(tp,g)
end