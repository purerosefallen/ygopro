--高速决斗技能-心灵扫描
Duel.LoadScript("speed_duel_common.lua")
function c100730120.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(34694160,c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730120.skill,c100730120.con,aux.Stringid(100730120,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730120.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnCount()>=3 and Duel.GetCurrentChain()==0
		and Duel.IsExistingMatchingCard(c100730120.filter,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.GetLP(tp)>=3000
end

function c100730120.filter(c)
	return c:GetFlagEffect(100730120)==0 and c:GetFlagEffectLabel(100730120)~=c:GetFieldID() and c:IsFacedown()
end

function c100730120.reg(c)
	c:RegisterFlagEffect(100730120,RESET_EVENT+RESETS_STANDARD+EVENT_FLIP,0,1,c:GetFieldID())
end

function c100730120.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(c100730120.filter,tp,0,LOCATION_ONFIELD,nil)
	if not g or g:GetCount()==0 then return end
	g:ForEach(c100730120.reg)
	Duel.ConfirmCards(tp,g)
end