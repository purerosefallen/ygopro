--高速决斗技能-抽卡预感：光
Duel.LoadScript("speed_duel_common.lua")
function c100730054.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(62867251,c)
	if not c100730054.UsedLP then
		c100730054.UsedLP={}
		c100730054.UsedLP[0]=0
		c100730054.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730054.skill,c100730054.con,aux.Stringid(100730054,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730054.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730054,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730054)
		c100730054.UsedLP[tp]=c100730054.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_LIGHT)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730054.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_LIGHT)>0
		and aux.DecreasedLP[tp]-c100730054.UsedLP[tp] >= 1500
end