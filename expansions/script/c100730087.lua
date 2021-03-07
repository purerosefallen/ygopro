--高速决斗技能-抽卡预感：光
Duel.LoadScript("speed_duel_common.lua")
function c100730087.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(62867251,c)
	if not c100730087.UsedLP then
		c100730087.UsedLP={}
		c100730087.UsedLP[0]=0
		c100730087.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730087.skill,c100730087.con,aux.Stringid(100730087,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730087.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730087,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730087)
		c100730087.UsedLP[tp]=c100730087.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,ATTRIBUTE_LIGHT)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730087.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,ATTRIBUTE_LIGHT)>0
		and aux.DecreasedLP[tp]-c100730087.UsedLP[tp] >= 1500
end